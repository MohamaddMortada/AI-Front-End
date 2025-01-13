import 'dart:convert';
import 'dart:io';
import 'package:front_end/widgets/alami_message.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/gradient_line.dart';
import 'package:front_end/widgets/upload.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/button.dart';

class Detect extends StatefulWidget {
  @override
  _DetectState createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  File? _media;
  final picker = ImagePicker();
  String _result = '';
  String _errorMessage = '';
  String _selectedMode = 'start';
  late double  correctPercentage =0.0;
  late bool isDetected = false;
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
                final file =
                    await picker.pickImage(source: ImageSource.gallery);
                Navigator.of(context)
                    .pop(file != null ? File(file.path) : null);
              },
              child: const Text('Image'),
            ),
            TextButton(
              onPressed: () async {
                final file =
                    await picker.pickVideo(source: ImageSource.gallery);
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
      });
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
        ? 'http://10.0.2.2:5000/${_selectedMode}_video'
        : 'http://10.0.2.2:5000/${_selectedMode}_image';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl),
    );

    String mediaType = _media!.path.endsWith('.mp4') ? 'video' : 'image';
    request.files
        .add(await http.MultipartFile.fromPath(mediaType, _media!.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final result = json.decode(responseData);

        setState(() {
          correctPercentage = double.parse(result.toString())/100;
          _errorMessage = '';
          isDetected = true;
        });
      } else {
        setState(() {
          _errorMessage =
              'Error detecting media. Status code: ${response.statusCode}';
          correctPercentage = 0.0;
          isDetected = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        correctPercentage = 0.0;
        isDetected = false;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileBar(),
                Image.asset('assets/sprint-start.png',width: 200,height: 200,),
                const Spacer(),

                AlamiMessage(text: "Upload an image or a video, and let’s start detecting", fontSize: 14, fontWeight:FontWeight.w500),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  width: 330,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: Theme.of(context).primaryColor,
                    dropdownColor: Theme.of(context).primaryColor,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    value: _selectedMode,
                    items: _modes.map((String mode) {
                      return DropdownMenuItem<String>(
                        value: mode,
                        child: Text(mode),
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
                Upload(onTap: _uploadMedia, media:_media),
                const SizedBox(height: 10),
                Main_Button(
                  text: 'Detect',
                  image: Image.asset('assets/Icons/detect.png'),
                  route: '/detecting',
                  onTap: () {
                    _detectMedia(context);
                  },
                ),
                const SizedBox(height: 20),
                if(isDetected)
                GradientLineWidget(percentage: correctPercentage, label: 'Correct'),
                const SizedBox(height: 10),
                if(isDetected)
                GradientLineWidget(percentage: 1-correctPercentage, label: 'Error'),
                /*if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style:
                        TextStyle(color: const Color.fromARGB(255, 130, 9, 0)),
                  ),*/
                 //Text('$correctPercentage'),
                const Spacer(),
              ],
            ),
          ),
        AssistiveBall(),
        ],
      ),
    );
  }
}
