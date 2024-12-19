import 'package:flutter/material.dart';
import 'package:front_end/pages/analyze.dart';
import 'package:front_end/pages/analyzing.dart';
import 'package:front_end/pages/calculate.dart';
import 'package:front_end/pages/chatbot.dart';
import 'package:front_end/pages/contact.dart';
import 'package:front_end/pages/detect.dart';
import 'package:front_end/pages/detecting.dart';
import 'package:front_end/pages/home.dart';
import 'package:front_end/pages/login.dart';
import 'package:front_end/pages/main_page.dart';
import 'package:front_end/pages/on_boarding.dart';
import 'package:front_end/pages/predict.dart';
import 'package:front_end/pages/predicting.dart';
import 'package:front_end/pages/profile.dart';
import 'package:front_end/pages/register.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return  GetMaterialApp(
      initialRoute: '/',  
      getPages: [
        GetPage(name: '/main', page: () => MainPage()),  
        GetPage(name: '/detect', page: () => Detect()), 
        GetPage(name: '/analyze', page: () => Analyze()), 
        GetPage(name: '/predict', page: () => Predict()),
        GetPage(name: '/calculate', page: () => Calculate()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/detecting', page: () => Detecting()),
        GetPage(name: '/analyzing', page: () => Analyzing()),
        GetPage(name: '/predicting', page: () => Predicting()),
        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/contact', page: () => Contact()),
        GetPage(name: '/chatbot', page: () => Chatbot()),

      ],
      theme: ThemeData(
        primaryColor: Color(0xFF006B8B),
        secondaryHeaderColor:Color(0xFFE1F7FF),
        scaffoldBackgroundColor: Color(0xFFB2C8D0),

      ),
      home:MainPage(),
      
    );
  }
}

