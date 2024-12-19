import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/upload.dart';

class Analyze extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Stack(
          children: [
             Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
            const ProfileBar(),
            const Spacer(),
            const Upload(),
            const SizedBox(height: 10,),
            Main_Button(text: 'Analyze', icon: const Icon(Icons.analytics), navigated: Analyze(),),
            const Spacer(),
            const Spacer(),
          ]),),
          AssistiveBall(),
      ])
    );
  }
}
