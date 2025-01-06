import 'package:flutter/material.dart';
import 'package:front_end/pages/login.dart';
import 'package:front_end/pages/register.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          Main_Button(text: 'Register',icon: Icons.app_registration_rounded, route: '/register', onTap: () { Get.toNamed('/register'); },),
          SizedBox(height: 10),
          Main_Button(text: 'Login',icon: Icons.login, route:'/login', onTap: () { Get.toNamed('/login'); },),
          Spacer(),
          Spacer(),
        ],
      ),
    ));
  }
}
