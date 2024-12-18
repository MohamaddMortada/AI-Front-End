import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/text_field.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
          ProfileBar(),
          Spacer(),
          Input(text: 'Type your message here', icon: Icon(Icons.message), height: 270, maxLines: 10, ),
          Main_Button(text:'Send Message', icon: Icon(Icons.email)),
          Spacer(),
        ])));}}