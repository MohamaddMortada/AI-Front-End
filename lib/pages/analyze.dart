
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
    } catch (e) {
      
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
      });

      videoPlayerController = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          setState(() {});
        });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Video saved at: $videoPath"),
      ));
      _sendDataToApi(videoPath, startTimestamp, endTimestamp);

    } catch (e) {

    }
  }

  Future<void> _sendDataToApi(String videoPath, DateTime startTimestamp, DateTime endTimestamp) async {
    try {
      var uri = Uri.parse("http://10.0.2.2:5000/..");
      var request = http.MultipartRequest("POST", uri);

      request.files.add(await http.MultipartFile.fromPath(
        'video', videoPath,
        contentType: MediaType('video', 'mp4'),
      ));

      request.fields['start_timestamp'] = startTimestamp.toIso8601String();
      request.fields['end_timestamp'] = endTimestamp.toIso8601String();

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
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}
