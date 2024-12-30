import 'dart:io';

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
            Upload(),
            SizedBox(height: 10,),
            Main_Button(text: 'Detect', icon: Icon(Icons.error), route: '/detecting', onTap: () {  },),
            Spacer(),
            Spacer(),
          ]),
        
      ),
      AssistiveBall()
      ]
    ));
  }
}

