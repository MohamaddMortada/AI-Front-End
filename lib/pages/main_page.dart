
import 'package:flutter/material.dart';
import 'package:front_end/widgets/image_button.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(imagePath: 'assets/Detect-Image.webp', text: 'DETECT'),
                  ImageButton(imagePath: 'assets/Analyze-Image.webp', text: 'ANALYZE'),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(imagePath: 'assets/Predict-Image.webp', text: 'PREDICT'),
                  ImageButton(imagePath: 'assets/Calculate-Image.webp', text: 'CALCULATE'),
                ],
              ),
              Spacer(),
            ]
          )
        )
    );
  }
}