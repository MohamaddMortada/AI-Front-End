
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';


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

    } catch (e) {

    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}
