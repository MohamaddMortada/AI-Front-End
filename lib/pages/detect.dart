import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/assistive_ball.dart';
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
  final List<String> _modes = ['start', 'set', 'hop', 'drive', 'sprint', 'run'];

  Future<void> _uploadMedia() async {
    final pickedFile = await showDialog<File?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Media'),
          actions: [
            TextButton(
              onPressed: () async {
                final file =
                    await picker.pickImage(source: ImageSource.gallery);
                Navigator.of(context)
                    .pop(file != null ? File(file.path) : null);
              },
              child: Text('Image'),
            ),
            TextButton(
              onPressed: () async {
                final file =
                    await picker.pickVideo(source: ImageSource.gallery);
                Navigator.of(context)
                    .pop(file != null ? File(file.path) : null);
              },
              child: Text('Video'),
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
          _result = result.toString();
          _errorMessage = '';
        });
      } else {
        setState(() {
          _errorMessage =
              'Error detecting media. Status code: ${response.statusCode}';
          _result = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _result = '';
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
                ProfileBar(),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  width: 270,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: Theme.of(context).primaryColor,
                    dropdownColor: Theme.of(context).primaryColor,
                    style: TextStyle(
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
                if (_media != null) Image.file(_media!),
                ElevatedButton(
                  onPressed: _uploadMedia,
                  child: Text('Upload Image/Video'),
                ),
                SizedBox(height: 10),
                Main_Button(
                  text: 'Detect',
                  icon: Icons.error,
                  route: '/detecting',
                  onTap: () {
                    _detectMedia(context);
                  },
                ),
                SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style:
                        TextStyle(color: const Color.fromARGB(255, 130, 9, 0)),
                  ),
                if (_result.isNotEmpty) Text(_result),
                Spacer(),
              ],
            ),
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
