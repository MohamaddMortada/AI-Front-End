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
          ButtonSecondary(text: 'Event', image: Image.asset('assets/Icons/lap.png'), onTap: () { print(''); },),
          const SizedBox(height: 10,),
          ButtonSecondary(text: 'Result', image: Image.asset('assets/Icons/clock.png'), onTap: () { print(''); },),
          const SizedBox(height: 10,),
          Container(color: Theme.of(context).primaryColor,width:270,height: 270,),
          const SizedBox(height: 10,),
          ButtonSecondary(text: 'Average Speed', image: Image.asset('assets/Icons/speed.png'), onTap: () { print(''); },),
          const SizedBox(height: 10,),
           Main_Button(text: 'Predict Another', image: Image.asset('assets/Icons/predict.png'), route: '/predict', onTap: () {  },),
          const Spacer(),
        ])),
        AssistiveBall(),
        ]));}}