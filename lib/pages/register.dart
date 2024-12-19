import 'package:flutter/material.dart';
import 'package:front_end/pages/home.dart';
import 'package:front_end/pages/main_page.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/main_logo.dart';
import 'package:front_end/widgets/text_field.dart';

class Register extends StatelessWidget {
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
              Input(text: 'Username', icon: Icon(Icons.person), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Email', icon: Icon(Icons.email), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Phone Number', icon: Icon(Icons.phone), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Password', icon: Icon(Icons.key), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Confirm Password', icon: Icon(Icons.key), height: 45, maxLines: 1),
              SizedBox(height: 20),
              Main_Button(text: 'Register',icon: Icon(Icons.app_registration_rounded), route: '/'),
              SizedBox(height: 10),
              Text('OR'),
              SizedBox(height: 10),
              Main_Button(text: 'Register with Google',icon: Icon(Icons.app_registration_rounded), route: '/',),
              Spacer(),
            ],
          )
        )
    );
  }
}