import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/pages/analyze.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/image_container.dart';
import 'package:front_end/widgets/profile_bar.dart';

class Predicting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
        body: Stack(
        children: [
           Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
          const ProfileBar(),
          const Spacer(),
          const ButtonSecondary(text: 'Event', icon: Icon(Icons.event)),
          const SizedBox(height: 10,),
          const ButtonSecondary(text: 'Result', icon: Icon(Icons.lock_clock)),
          const SizedBox(height: 10,),
          Container(color: Theme.of(context).primaryColor,width:270,height: 270,),
          const SizedBox(height: 10,),
          const ButtonSecondary(text: 'Average Speed', icon: Icon(Icons.speed)),
          const SizedBox(height: 10,),
           Main_Button(text: 'Predict Another', icon: Icon(Icons.analytics), route: '/predict',),
          const Spacer(),
        ])),
        AssistiveBall(),
        ]));}}