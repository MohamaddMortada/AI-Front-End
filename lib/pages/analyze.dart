import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FinishLine extends StatefulWidget {
  @override
  _FinishLineState createState() => _FinishLineState();
}

class _FinishLineState extends State<FinishLine> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isRecording = false;
  late DateTime startTimestamp;
  late DateTime endTimestamp;
  late String videoPath;
  VideoPlayerController? videoPlayerController;

  String accurateTime = '';

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception("No cameras available on this device.");
      }

      _controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );

      await _controller.initialize();

      setState(() {});
    } catch (e) {}
  }

  Future<void> _startRecording() async {
    if (!_controller.value.isInitialized || isRecording) return;

    try {
      startTimestamp = DateTime.now();

      final directory = await getApplicationDocumentsDirectory();
      videoPath =
          '${directory.path}/video_${startTimestamp.millisecondsSinceEpoch}.mp4';

      await _controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {}
  }

  Future<void> _stopRecording() async {
    if (!_controller.value.isRecordingVideo || !isRecording) return;

    try {
      endTimestamp = DateTime.now();

      XFile videoFile = await _controller.stopVideoRecording();

      videoPath = videoFile.path;

      setState(() {
        isRecording = false;
      });

      videoPlayerController = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          setState(() {});
        });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Video saved at: $videoPath"),
      ));
      String fireTimestampstring = await _getFireTimestamp();
      DateTime fireTimestamp = DateTime.parse(fireTimestampstring);
      _sendDataToApi(videoPath, startTimestamp, endTimestamp, fireTimestamp);
    } catch (e) {}
  }

  Future<String> _getFireTimestamp() async {
  try {
    final String syncKey = ""; 

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/getfiretimestamp'), 
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'sync_key': syncKey}),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['fire_timestamp'];
    } else {
      throw Exception('Failed to get fire timestamp from API');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Failed to get fire timestamp: $e"),
    ));
    return '';
  }
}

  Future<void> _sendDataToApi(
      String videoPath, DateTime startTimestamp, DateTime endTimestamp, DateTime fireTimestamp) async {
    try {
      var uri = Uri.parse("http://10.0.2.2:5000/..");
      var request = http.MultipartRequest("POST", uri);

      request.files.add(await http.MultipartFile.fromPath(
        'video',
        videoPath,
        contentType: MediaType('video', 'mp4'),
      ));

      request.fields['start_timestamp'] = startTimestamp.toIso8601String();
      request.fields['end_timestamp'] = endTimestamp.toIso8601String();
      request.fields['fire_timestamp'] = fireTimestamp.toIso8601String();

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        setState(() {
          accurateTime = responseString;
        });
      } else {
        setState(() {
          accurateTime = "Failed to upload video.";
        });
      }
    } catch (e) {
      setState(() {
        accurateTime = "Error sending data to API.";
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: _controller.value.isInitialized
          ? Column(children: [
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
                    videoPlayerController != null && videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(videoPlayerController!),
                        )
                      : Container(),
                  SizedBox(height: 20),
                
                  accurateTime.isNotEmpty
                      ? Text(
                          "Response from API: $accurateTime",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        )
                      : Container(),
          ])
          : Center(child: CircularProgressIndicator()),
    ));
  }
}
