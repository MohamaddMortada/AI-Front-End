
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FinishLine extends StatefulWidget {
  @override
  _FinishLineState createState() => _FinishLineState();
}

class _FinishLineState extends State<FinishLine> {
    late CameraController _controller;
  late List<CameraDescription> cameras;

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}
