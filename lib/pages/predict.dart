import 'package:flutter/material.dart';
import 'package:front_end/pages/home.dart';
import 'package:front_end/pages/predicting.dart';
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
                  Text_Field(text: 'Input some previous Results: ', fontSize: 18, fontWeight: FontWeight.normal),
                  SizedBox(height: 10,),
                  Input(text: 'Distance', icon: Icon(Icons.social_distance), height: 45, maxLines: 1, controller: distanceController,),
                  SizedBox(height: 10,),
                  Input(text: 'Time', icon: Icon(Icons.lock_clock), height: 45, maxLines: 1, controller: distanceController,),
                  SizedBox(height: 10,),
                  ButtonSecondary(text: 'Add Result', icon: Icon(Icons.add),),
                  SizedBox(height: 10,),
                   Main_Button(text: 'Predict', icon: Icon(Icons.batch_prediction), route: '/predicting', onTap: () {  },),
                  Spacer(),

                ]
              )
          ),
          AssistiveBall(),
  ]));
  }
}
