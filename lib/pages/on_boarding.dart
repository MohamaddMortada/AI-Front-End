import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MainLogo(),
          Text_Field(
            text: 'ATHLETIC PERFORMANCE',
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          Spacer(),
          Text_Field(
            text: "For a better performance,\nlet’s get in.",
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          SizedBox(height: 10),
          Main_Button(text: 'Register',icon: Icon(Icons.app_registration_rounded)),
          SizedBox(height: 10),
          Main_Button(text: 'Login',icon: Icon(Icons.login)),
          Spacer(),
        ],
      ),
    ));
  }
}
