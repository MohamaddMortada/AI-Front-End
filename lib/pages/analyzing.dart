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
        ProfileBar(),
        Spacer(),
        ButtonSecondary(text: 'Distance', image: Image.asset('assets/Icons/lap.png'), onTap: () { print(''); },),
        SizedBox(
          height: 10,
        ),
        ButtonSecondary(text: 'Result', image: Image.asset('assets/Icons/clock.png'), onTap: () { print(''); },),
        SizedBox(
          height: 10,
        ),
        ImageContainer(
            imageUrl:
                'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp'),
        SizedBox(
          height: 10,
        ),
        ButtonSecondary(text: 'Average Speed', image: Image.asset('assets/Icons/speed.png'), onTap: () { print(''); },),
        SizedBox(
          height: 10,
        ),
        Main_Button(text: 'Analyze Another', image: Image.asset('assets/Icons/analyze.png'), route: '/analyze', onTap: () {  },),
        Spacer(),
      ])),
      AssistiveBall(),
    ]));
  }
}
