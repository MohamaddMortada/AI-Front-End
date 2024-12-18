
import 'package:flutter/material.dart';
import 'package:front_end/widgets/image_button.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/profile_widget.dart';
import 'package:front_end/widgets/text_field.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
          
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileBar(), 
              Text_Field(text: 'Welcome Nabiha \n to AP', fontSize: 24, fontWeight: FontWeight.bold),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(imagePath: 'assets/Detect-Image.webp', text: 'DETECT', discription: 'DETECT & FIX \nERRORS',),
                  ImageButton(imagePath: 'assets/Analyze-Image.webp', text: 'ANALYZE', discription: 'ANALYZE YOUR PERFORMANCE',),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(imagePath: 'assets/Predict-Image.webp', text: 'PREDICT', discription: 'PREDICT FUTURE PERFORMANCES',),
                  ImageButton(imagePath: 'assets/Calculate-Image.webp', text: 'CALCULATE', discription: 'CALCULATE YOUR \nPOINTS',),
                ],
              ),
              Spacer(),
              Spacer(),
            ]
          )
        );
    
  }
}