import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/controllers/auth_controller.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';

class Login extends StatelessWidget {
  final AuthController controller = AuthController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 40),
        const MainLogo(),
        const Text(
          'ATHLETIQ',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Input(
          text: 'Email',
          image: Image.asset('assets/Icons/email.png'),
          height: 45,
          maxLines: 1,
          controller: emailController,
        ),
        const SizedBox(height: 10),
        Input(
          text: 'Password',
          image: Image.asset('assets/Icons/key.png'),
          height: 45,
          maxLines: 1,
          controller: passwordController,
        ),
        const SizedBox(height: 10),
        const Padding(
            padding: EdgeInsets.only(left: 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot your password',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            )),
        const SizedBox(height: 10),
        Main_Button(
          text: 'Login',
          image: Image.asset('assets/Icons/login.png'),
          route: '/main',
          onTap: () {
            controller.loginUser(
              context,
              emailController.text.trim(),
              passwordController.text.trim(),
            );
          },
        ),
        const SizedBox(height: 10),
        const Spacer(),
      ],
    )));
  }
}
