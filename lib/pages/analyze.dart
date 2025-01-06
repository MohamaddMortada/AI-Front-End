import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/upload.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Analyze extends StatelessWidget {
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
            //Upload(),
            SizedBox(height: 10,),
            Main_Button(text: 'Analyze', image: Image.asset('assets/Icons/analyze.png'), route: '/analyzing', onTap: (){Get.toNamed('/analyzing');},),
            Spacer(),
            Spacer(),
          ]),),
          AssistiveBall(),
      ])
    );
  }
}
