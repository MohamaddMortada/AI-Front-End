import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/text_field.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            const Center(
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              Text_Field(text: 'Changing your Password', fontSize: 20, fontWeight: FontWeight.w500),
              SizedBox(height: 30),
              Input(text: 'Old Password', icon: Icon(Icons.key), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'New Password', icon: Icon(Icons.key), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Confirm Password', icon: Icon(Icons.key), height: 45, maxLines: 1),
              SizedBox(height: 30),
              Main_Button(text: 'Update Password', icon: Icon(Icons.update)),
              Spacer(),
            ]
          )
        ),AssistiveBall()])
    );
  }
}