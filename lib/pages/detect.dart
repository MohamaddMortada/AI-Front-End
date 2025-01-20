import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:front_end/widgets/alami_message.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/gradient_line.dart';
import 'package:front_end/widgets/upload.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/button.dart';
import 'package:video_player/video_player.dart';

class Detect extends StatefulWidget {
  @override
  _DetectState createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  File? _media;
  VideoPlayerController? _videoController;
  final picker = ImagePicker();
  String _result = '';
  String _errorMessage = '';
  String _selectedMode = 'start';
  late double correctPercentage = 0.0;
  late bool isDetected = false;
  bool noResultFound = false;
  final List<String> _modes = ['start', 'set', 'hop', 'drive', 'sprint', 'run'];

  Future<void> _uploadMedia() async {
    final pickedFile = await showDialog<File?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Media'),
          actions: [
            TextButton(
              onPressed: () async {
                final file = await picker.pickImage(source: ImageSource.gallery);
                Navigator.of(context)
                    .pop(file != null ? File(file.path) : null);
              },
              child: const Text('Image'),
            ),
            TextButton(
              onPressed: () async {
                final file = await picker.pickVideo(source: ImageSource.gallery);
                Navigator.of(context)
                    .pop(file != null ? File(file.path) : null);
              },
              child: const Text('Video'),
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _media = pickedFile;
        _errorMessage = '';
        noResultFound = false;
      });

      if (_media!.path.endsWith('.mp4')) {
        _videoController = VideoPlayerController.file(_media!)
          ..initialize().then((_) {
            setState(() {});
          });
      }
    }
  }

  Future<void> _detectMedia(BuildContext context) async {
    if (_media == null) {
      setState(() {
        _errorMessage = 'Please upload an image or video first.';
      });
      return;
    }

    String apiUrl = _media!.path.endsWith('.mp4')
        ? 'http://192.168.2.103:5000/${_selectedMode}_video'
        : 'http://192.168.2.103:5000/${_selectedMode}_image';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl),
    );

    String mediaType = _media!.path.endsWith('.mp4') ? 'video' : 'image';
    request.files.add(await http.MultipartFile.fromPath(mediaType, _media!.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final result = json.decode(responseData);

        setState(() {
          correctPercentage =
              double.parse(result['correct_percentage'].toString()) / 100;
          _errorMessage = '';
          isDetected = true;
          noResultFound = correctPercentage == 0.0;
        });
      } else {
        setState(() {
          _errorMessage =
              'Error detecting media. Status code: ${response.statusCode}';
          correctPercentage = 0.0;
          isDetected = false;
          noResultFound = true;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        correctPercentage = 0.0;
        isDetected = false;
        noResultFound = true;
      });
    }
  }

  Future<String?> _getOpenAITips(
      Map<String, dynamic> angles,
      Map<String, dynamic> anglesData,
      Map<String, dynamic> correctAngles) async {
    const String openAIKey = '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';
    const String openAIUrl = 'https://api.openai.com/v1/completions';

    try {
      final response = await http.post(
        Uri.parse(openAIUrl),
        headers: {
          'Authorization': 'Bearer $openAIKey',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are an assistant that provides tips to fix pose-related issues in track and field exercises.'
            },
            {
              'role': 'user',
              'content': '''
The detected angles are:
$angles

The angle correctness is:
$anglesData

The correct angle ranges are:
$correctAngles

Please provide tips to improve the incorrect poses.
'''
            }
          ],
          'max_tokens': 150,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final String tips = responseData['choices'][0]['message']['content'];
        return tips;
      } else {
        debugPrint('OpenAI API Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error calling OpenAI API: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  const ProfileBar(),
                  Positioned(
                    left: 10,
                    top: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'DETECT & FIX',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        AlamiMessage(
                          text:
                              "Upload an image or a video, and let’s start detecting",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 128, 166, 179),
                          ),
                          width: 350,
                          height: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 330,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(10),
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  dropdownColor:
                                      Theme.of(context).primaryColor,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  value: _selectedMode,
                                  items: _modes.map((String mode) {
                                    return DropdownMenuItem<String>(
                                      value: mode,
                                      child: Text(mode.toUpperCase()),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedMode = newValue!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Upload(onTap: _uploadMedia, media: _media),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_media != null)
                          Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: _media!.path.endsWith('.mp4')
                                ? _videoController != null &&
                                        _videoController!.value.isInitialized
                                    ? AspectRatio(
                                        aspectRatio: _videoController!
                                            .value.aspectRatio,
                                        child: VideoPlayer(_videoController!),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                : Image.file(
                                    _media!,
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.fitHeight,
                                  ),
                          ),
                        const SizedBox(height: 20),
                        Main_Button(
                          text: 'Detect',
                          image: Image.asset('assets/Icons/detect.png'),
                          route: '/detecting',
                          onTap: () {
                            _detectMedia(context);
                          },
                        ),
                        const SizedBox(height: 10),
                        
                        if (isDetected)
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 128, 166, 179),
                              ),
                              height: 80,
                              width: 330,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GradientLineWidget(
                                      percentage: correctPercentage,
                                      label: 'Correct'),
                                  const SizedBox(height: 10),
                                  GradientLineWidget(
                                      percentage: 1 - correctPercentage,
                                      label: 'Error'),
                                ],
                              )),
                        if (noResultFound)
                          const Column(
                            children: [
                              Text(
                                'No results found, try adjusting to find what you are detecting.',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 130, 9, 0),
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
