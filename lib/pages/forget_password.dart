import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';

class ForgetPassword extends StatelessWidget {
    
  final TextEditingController emailController = TextEditingController();

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
              Input(text: 'Email', image: Image.asset('assets/Icons/email.png'), height: 45, maxLines: 1, controller: emailController,),
              SizedBox(height: 10),
             ButtonSecondary(text: 'Send New Password',image: Image.asset('assets/Icons/send.png'), onTap: () { print(''); },),
              Spacer(),
              Spacer(),
            ]
          )
        )
    );
  }
}