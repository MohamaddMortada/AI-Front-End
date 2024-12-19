import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_bar.dart';

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ProfileBar(),
        Spacer(),
        ButtonSecondary(text: 'Event', icon: Icon(Icons.event)),
        SizedBox(
          height: 10,
        ),
        Input(
            text: 'Result',
            icon: Icon(Icons.lock_clock),
            height: 45,
            maxLines: 1),
        SizedBox(
          height: 10,
        ),
        ButtonSecondary(text: 'Calculate', icon: Icon(Icons.calculate)),
        SizedBox(
          height: 10,
        ),
        Input(text: 'Score', icon: Icon(Icons.score), height: 45, maxLines: 1),
        Spacer(),
      ])),
      AssistiveBall()
    ]));
  }
}
