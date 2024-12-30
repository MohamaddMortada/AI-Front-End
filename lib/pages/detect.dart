import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front_end/pages/detecting.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/upload.dart';
import 'package:image_picker/image_picker.dart';


class Detect extends StatefulWidget {

  @override
  _DetectState createState() => _DetectState();
}
class _DetectState extends State<Detect> {
  File? _image; 
  final picker = ImagePicker();

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _detectImage(BuildContext context) async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload an image first.')),
      );
      return;
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5000/detect_image'), 
    );
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final result = json.decode(String.fromCharCodes(responseData));
      print(result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error detecting image.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body:Stack(
          children: [
               Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
            ProfileBar(),
            Spacer(),
            ElevatedButton(onPressed: _uploadImage, child: Text('Upload')),
            SizedBox(height: 10,),
            Main_Button(text: 'Detect', icon: Icon(Icons.error), route: '/detecting', onTap: (){_detectImage(context);}),
            Spacer(),
            Spacer(),
          ]),
        
      ),
      AssistiveBall()
      ]
    ));
  }
}

