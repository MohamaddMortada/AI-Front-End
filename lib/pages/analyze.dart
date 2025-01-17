import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class FinishLine extends StatefulWidget {
  @override
  _FinishLineState createState() => _FinishLineState();
}

class _FinishLineState extends State<FinishLine> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isRecording = false;
  String videoPath = '';
  VideoPlayerController? videoPlayerController;
  double crossingTime = 0.0;
  String res = '';
  DateTime fireTimestamp =DateTime.now();
  DateTime startTimestamp =DateTime.now();
  //Duration subTime = ;
  double finalTime = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) throw Exception("No cameras available on this device.");

      _controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );

      await _controller.initialize();
      setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initializing camera: $e")),
      );
    }
  }

  Future<void> _startRecording() async {
    if (!_controller.value.isInitialized || isRecording) return;

    try {
      final directory = await getApplicationDocumentsDirectory();
      videoPath = '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      await _controller.startVideoRecording();
      setState(() {
        startTimestamp = DateTime.now();
        isRecording = true;
      });
    } catch (e) {
      print("Error starting video recording: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error starting video recording: $e")),
      );
    }
  }

  Future<void> _stopRecording() async {
    if (!_controller.value.isRecordingVideo || !isRecording) return;

    try {
      XFile videoFile = await _controller.stopVideoRecording();
      videoPath = videoFile.path;

      setState(() {
        isRecording = false;
        videoPlayerController = VideoPlayerController.file(File(videoPath))
          ..initialize().then((_) {
            setState(() {});
          });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Video saved at: $videoPath")),
      );
      await _getFireTimestamp();
      await _sendDataToApi(videoPath);
      setState(() {
        Duration subTime = fireTimestamp.difference(startTimestamp);
        finalTime = crossingTime - subTime.inSeconds;

      });
    } catch (e) {
      print("Error stopping video recording: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error stopping video recording: $e")),
      );
    }
  }

    Future<String> _getSyncKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('sync_key') ?? '';
  }

  Future<void> _getFireTimestamp() async {
    try {
      String syncKey = await _getSyncKey();
      if (syncKey.isEmpty) throw Exception('Sync key is empty.');

      final response = await http.post(
        Uri.parse('http://192.168.199.124:8000/api/getfiretimestamp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'sync_key': syncKey}),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          fireTimestamp = DateTime.parse(data['fire_timestamp']);
        });
      } else {
        throw Exception('Failed to get fire timestamp from API');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to get fire timestamp: $e")),
      );
    }
  }

  Future<void> _sendDataToApi(String videoPath) async {
    try {
      var uri = Uri.parse("http://192.168.199.124:5000/middle-crossing");
      var request = http.MultipartRequest("POST", uri);

      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videoPath,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var data = json.decode(responseString);

        if (data.containsKey('crossing_time')) {
          setState(() {
            crossingTime = double.parse(data['crossing_time'].toString());
            res = "Crossing time: ${data['crossing_time']} seconds";
          });
        } else {
          throw Exception('Unexpected response format: $data');
        }
      } else {
        throw Exception('API error: ${response.statusCode}');
      }
    } catch (e) {
      print("Error sending video to API: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending video to API: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Finish Line")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _controller.value.isInitialized
            ? Column(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                  SizedBox(height: 20),
                  isRecording
                      ? ElevatedButton(
                          onPressed: _stopRecording,
                          child: Text("Stop Recording"),
                        )
                      : ElevatedButton(
                          onPressed: _startRecording,
                          child: Text("Start Recording"),
                        ),
                  SizedBox(height: 20),
                  Text(
                    res.isNotEmpty ? res : "No result yet.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Crossing Time: $crossingTime seconds',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Final Time: $finalTime'),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
