import 'package:flutter/material.dart';
import 'package:front_end/controllers/login_controller.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';

class Login extends StatelessWidget {
  final LoginController controller = LoginController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              Input(text: 'Username', icon: Icon(Icons.person), height: 45, maxLines: 1, controller: nameController,),
              SizedBox(height: 10),
              Input(text: 'Password', icon: Icon(Icons.key), height: 45, maxLines: 1, controller: passwordController,),
              SizedBox(height: 10),
              Text_Field(
                text: 'Forgot your Password',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 10),
              Main_Button(
                text: 'Login',icon: Icon(Icons.login), route: '/main', 
                onTap: () { 
                   controller.loginUser(
                    context,
                  nameController.text.trim(),
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