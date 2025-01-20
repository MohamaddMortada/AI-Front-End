import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/profile_bar.dart';
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
  DateTime fireTimestamp = DateTime.now();
  DateTime startTimestamp = DateTime.now();
  double finalTime = 0;
  bool isProcessing = false;

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
      if (cameras.isEmpty)
        throw Exception("No cameras available on this device.");

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
      videoPath =
          '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

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

    setState(() {
      isProcessing = true; // Show the loading indicator
    });

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

      await _getFireTimestamp();
      await _sendDataToApi(videoPath);
      setState(() {
        Duration subTime = fireTimestamp.difference(startTimestamp);
        finalTime = crossingTime - subTime.inSeconds;
        finalTime = double.parse(finalTime.toStringAsFixed(4));
        isProcessing = false; // Hide the loading indicator
      });
    } catch (e) {
      print("Error stopping video recording: $e");
      setState(() {
        isProcessing = false; // Hide the loading indicator on error
      });
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
        Uri.parse('http://192.168.43.170:8000/api/getfiretimestamp'),
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
      var uri = Uri.parse("http://192.168.43.170:5000/middle-crossing");
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
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: _controller.value.isInitialized
            ? Column(
                children: [
                  ProfileBar(),
                  const Text(
                    'Finish Line',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 300,
                    height: 300,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                  ),
                  const SizedBox(height: 20),
                  isRecording
                      ? Column(
                          children: [
                            const Text(
                              'Make sure the athlete finishes before pressing "STOP"',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            ButtonSecondary(
                              text: 'STOP',
                              image: Image.asset('assets/Icons/stop.png'),
                              onTap: () {
                                _stopRecording();
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const Text(
                              'Make sure to press "START" here before the shot begins.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            ButtonSecondary(
                              text: 'START',
                              image: Image.asset('assets/Icons/start.png'),
                              onTap: () {
                                _startRecording();
                              },
                            ),
                          ],
                        ),
                  const SizedBox(height: 20),
                  if (isProcessing)
                    const CircularProgressIndicator(), 
                  if (!isProcessing && !isRecording)
                    Text(
                      'Electric Time:\n $finalTime',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    ));
  }
}
