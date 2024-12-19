import 'package:flutter/material.dart';
import 'package:front_end/pages/login.dart';
import 'package:front_end/pages/register.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MainLogo(),
          const Text_Field(
            text: 'ATHLETIC PERFORMANCE',
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          const Spacer(),
          const Text_Field(
            text: "For a better performance,\nlet’s get in.",
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          const SizedBox(height: 10),
          Main_Button(text: 'Register',icon: const Icon(Icons.app_registration_rounded), navigated: Register(),),
          const SizedBox(height: 10),
          Main_Button(text: 'Login',icon: const Icon(Icons.login), navigated: Login(),),
          const Spacer(),
          const Spacer(),
        ],
      ),
    ));
  }
}
