import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinishLine extends StatefulWidget {
  @override
  _FinishLineState createState() => _FinishLineState();
}

class _FinishLineState extends State<FinishLine> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isRecording = false;
  late DateTime startTimestamp = DateTime.now();
  late DateTime endTimestamp = DateTime.now();
  late String videoPath;
  VideoPlayerController? videoPlayerController;

  String accurateTime = '';
  late DateTime fireTimestamp = DateTime.now();

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
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> _startRecording() async {
    if (!_controller.value.isInitialized || isRecording) return;

    try {
      startTimestamp = DateTime.now();

      final directory = await getApplicationDocumentsDirectory();
      videoPath = '${directory.path}/video_${startTimestamp.millisecondsSinceEpoch}.mp4';

      await _controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print("Error starting video recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    if (!_controller.value.isRecordingVideo || !isRecording) return;

    try {
      endTimestamp = DateTime.now();

      XFile videoFile = await _controller.stopVideoRecording();
      videoPath = videoFile.path;

      setState(() {
        isRecording = false;
        videoPlayerController = VideoPlayerController.file(File(videoPath))
          ..initialize().then((_) {
            setState(() {});
          });
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Video saved at: $videoPath"),
      ));

       _sendDataToApi(videoPath);
    } catch (e) {
      print("Error stopping video recording: $e");
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

        if (response.headers['content-type']!.contains('application/json')) {
          var data = json.decode(responseString);

          if (data.containsKey('crossing_time')) {
            setState(() {
              accurateTime = "Crossing Time: ${data['crossing_time']} seconds";
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Video processed successfully!")),
            );
          } else if (data.containsKey('message')) {
            setState(() {
              accurateTime = data['message'];
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'])),
            );
          } else {
            setState(() {
              accurateTime = "Unexpected response data: $data";
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Unexpected response data.")),
            );
          }
        } else {
          setState(() {
            accurateTime = "Unexpected response format:\n$responseString";
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Unexpected response format from the server.")),
          );
        }
      } else {
        var responseString = await response.stream.bytesToString();
        setState(() {
          accurateTime = "Error: ${response.statusCode}\n$responseString";
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to communicate with the API. Status: ${response.statusCode}"),
        ));
      }
    } catch (e) {
      setState(() {
        accurateTime = "Error sending data to API: $e";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending data to API: $e")),
      );
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
                    "Response from API: $accurateTime",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
