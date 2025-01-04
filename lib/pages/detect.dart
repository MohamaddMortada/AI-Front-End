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
  File? _image;
  final picker = ImagePicker();
  String _result = '';
  String _errorMessage = '';

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _errorMessage = '';
      });
    }
  }

  Future<void> _detectImage(BuildContext context) async {
    if (_image == null) {
      setState(() {
        _errorMessage = 'Please upload an image first.';
      });
      return;
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:5000/detect_image'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

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
              'Error detecting image. Status code: ${response.statusCode}'; // Set error message
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
                if (_image != null) Image.file(_image!),
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: Text('Upload'),
                ),
                SizedBox(height: 10),
                Main_Button(
                  text: 'Detect',
                  icon: Icons.error,
                  route: '/detecting',
                  onTap: () {
                    _detectImage(context);
                  },
                ),
                SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Text(_errorMessage, style: TextStyle(color: Colors.red)),
                if (_result.isNotEmpty) Text('Result: $_result'),
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
