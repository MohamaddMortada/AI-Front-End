import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MainLogo(),
              const Text_Field(
                text: 'ATHLETIC PERFORMANCE',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              const Input(text: 'Username', icon: Icon(Icons.person), height: 45, maxLines: 1),
              const SizedBox(height: 10),
              const Input(text: 'Password', icon: Icon(Icons.key), height: 45, maxLines: 1),
              const SizedBox(height: 10),
              const Text_Field(
                text: 'Forgot your Password',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              Main_Button(text: 'Login',icon: const Icon(Icons.login), navigated: Login(),),
              const SizedBox(height: 10),
              const Spacer(),

            ],
          )
        )
    );
  }
}