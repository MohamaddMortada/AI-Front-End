import 'package:flutter/material.dart';
import 'package:front_end/pages/analyze.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/image_container.dart';
import 'package:front_end/widgets/profile_bar.dart';

class Analyzing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
       Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const ProfileBar(),
        const Spacer(),
        const ButtonSecondary(text: 'Distance', icon: Icon(Icons.event)),
        const SizedBox(
          height: 10,
        ),
        const ButtonSecondary(text: 'Result', icon: Icon(Icons.lock_clock)),
        const SizedBox(
          height: 10,
        ),
        const ImageContainer(
            imageUrl:
                'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp'),
        const SizedBox(
          height: 10,
        ),
        const ButtonSecondary(text: 'Average Speed', icon: Icon(Icons.speed)),
        const SizedBox(
          height: 10,
        ),
        Main_Button(text: 'Analyze Another', icon: const Icon(Icons.analytics), navigated: Analyze(),),
        const Spacer(),
      ])),
      AssistiveBall(),
    ]));
  }
}
