import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
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
          const Main_Button(text: 'Event', icon: Icon(Icons.event)),
          const SizedBox(height: 10,),
          const Main_Button(text: 'Result', icon: Icon(Icons.lock_clock)),
          const SizedBox(height: 10,),
          Container(color: Theme.of(context).primaryColor,width:270,height: 270,),
          const SizedBox(height: 10,),
          const Main_Button(text: 'Average Speed', icon: Icon(Icons.speed)),
          const SizedBox(height: 10,),
          const Main_Button(text: 'Analyze Another', icon: Icon(Icons.analytics)),
          const Spacer(),
        ])),
        AssistiveBall(),
        ]));}}