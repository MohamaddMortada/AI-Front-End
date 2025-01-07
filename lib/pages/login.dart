import 'package:flutter/material.dart';
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
    return  Scaffold(
        body: Center(
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 40),
              MainLogo(),
              Text_Field(
                text: 'ATHLETIQ',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              Spacer(),
              Input(text: 'Email', image: Image.asset('assets/Icons/email.png'), height: 45, maxLines: 1, controller: emailController,),
              SizedBox(height: 10),
              Input(text: 'Password', image: Image.asset('assets/Icons/key.png'), height: 45, maxLines: 1, controller: passwordController,),
              SizedBox(height: 10),
              Text_Field(
                text: 'Forgot your Password',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 10),
              Main_Button(
                text: 'Login',image: Image.asset('assets/Icons/login.png'), route: '/main', 
                onTap: () { 
                   controller.loginUser(
                    context,
                    emailController.text.trim(),
                    passwordController.text.trim(),
                   );
                 },),
              SizedBox(height: 10),
              Spacer(),

            ],
          )
        )
    );
  }
}