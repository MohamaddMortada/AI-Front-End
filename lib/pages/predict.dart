import 'package:flutter/material.dart';
import 'package:front_end/pages/home.dart';
import 'package:front_end/pages/predicting.dart';
import 'package:front_end/widgets/alami_message.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/text_field.dart';

class Predict extends StatelessWidget {
  
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
        children: [
           Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: [
                  ProfileBar(),
                  Spacer(),
                  AlamiMessage(text: 'Wanna know how much you can run right now!?', fontSize: 14, fontWeight: FontWeight.w500),
                  SizedBox(height: 10,),
                  Text_Field(text: 'Input some previous Results: ', fontSize: 18, fontWeight: FontWeight.normal),
                  SizedBox(height: 10,),
                  Input(text: 'Distance',image: Image.asset('assets/Icons/lap.png'), height: 45, maxLines: 1, controller: distanceController,),
                  SizedBox(height: 10,),
                  Input(text: 'Time',image: Image.asset('assets/Icons/clock.png'), height: 45, maxLines: 1, controller: distanceController,),
                  SizedBox(height: 10,),
                  ButtonSecondary(text: 'Add Result',image: Image.asset('assets/Icons/add.png'), onTap: () { print(''); },),
                  SizedBox(height: 10,),
                  Main_Button(text: 'Predict',image: Image.asset('assets/Icons/predict.png'), route: '/predicting', onTap: () {  },),
                  Spacer(),

                ]
              )
          ),
          AssistiveBall(),
  ]));
  }
}
