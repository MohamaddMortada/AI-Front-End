import 'package:flutter/material.dart';
import 'package:front_end/pages/analyze.dart';
import 'package:front_end/pages/calculate.dart';
import 'package:front_end/pages/detect.dart';
import 'package:front_end/pages/predict.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/image_button.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/text_field.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileBar(), 
              Text_Field(text: 'Welcome Nabiha \n to AthletiQ', fontSize: 24, fontWeight: FontWeight.bold),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(imagePath: 'assets/Detect-Image.webp', text: 'DETECT', discription: 'DETECT & FIX \nERRORS', route: '/detect',),
                  ImageButton(imagePath: 'assets/Analyze-Image.webp', text: 'ANALYZE', discription: 'ANALYZE YOUR PERFORMANCE',route: '/analyze'),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(imagePath: 'assets/Predict-Image.webp', text: 'PREDICT', discription: 'PREDICT FUTURE PERFORMANCES',route: '/predict'),
                  ImageButton(imagePath: 'assets/Calculate-Image.webp', text: 'CALCULATE', discription: 'CALCULATE YOUR \nPOINTS',route: '/calculate'),
                ],
              ),
              Spacer(),
              Spacer(),
            ]
          ),
          //AssistiveBall(),
          
         
        ],
      ),
    );
  }
}
