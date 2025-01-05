import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_bar.dart';

class Contact extends StatelessWidget {

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Stack(
          children: [
             Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
          ProfileBar(),
          
          Spacer(),
          Input(text: 'Type your message here', icon: Icon(Icons.message), height: 270, maxLines: 10, controller: messageController, ),
          ButtonSecondary(text:'Send Message', icon: Icon(Icons.email), onTap: () { print(''); },),
          Spacer(),
          Spacer(),
        ])),
        AssistiveBall(),
          ],
        ),
        );}}