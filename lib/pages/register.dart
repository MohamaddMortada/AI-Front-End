import 'package:flutter/material.dart';
import 'package:front_end/controllers/register_controller.dart';
import 'package:front_end/pages/home.dart';
import 'package:front_end/pages/main_page.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/register_google.dart';
import 'package:front_end/widgets/text_field.dart';

class Register extends StatelessWidget {
  final RegisterController controller = RegisterController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Center(
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainLogo(),
              Text_Field(
                text: 'ATHLETIC PERFORMANCE',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              Spacer(),
              Input(text: 'Username', image: Image.asset('assets/Icons/person.png'), height: 45, maxLines: 1, controller: usernameController,),
              SizedBox(height: 10),
              Input(text: 'Email', image: Image.asset('assets/Icons/email.png'), height: 45, maxLines: 1, controller: emailController),
              SizedBox(height: 10),
              Input(text: 'Phone Number', image: Image.asset('assets/Icons/phone.png'), height: 45, maxLines: 1, controller: numberController),
              SizedBox(height: 10),
              Input(text: 'Password', image: Image.asset('assets/Icons/key.png'), height: 45, maxLines: 1, controller: passwordController),
              SizedBox(height: 10),
              Input(text: 'Confirm Password', image: Image.asset('assets/Icons/key.png'), height: 45, maxLines: 1, controller: confirmPasswordController),
              SizedBox(height: 20),
              Main_Button(
                text: 'Register',icon: Icons.app_registration_rounded, route: '/main', 
                onTap: () =>controller.registerUser(
                   context,
                  usernameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  confirmPasswordController.text.trim()
                ),),
              SizedBox(height: 10),
              Text('OR'),
              SizedBox(height: 10),
              RegisterGoogle(),
              Spacer(),
            ],
          )
        )
    );
  }
}