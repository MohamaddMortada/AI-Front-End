import 'package:flutter/material.dart';
import 'package:front_end/pages/detect.dart';
import 'package:front_end/pages/detecting.dart';
import 'package:front_end/pages/home.dart';
import 'package:front_end/pages/main_page.dart';
import 'package:front_end/pages/predict.dart';
import 'package:front_end/pages/predicting.dart';
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
        GetPage(name: '/', page: () => MainPage()),  
        GetPage(name: '/detect', page: () => Detect()), 
        GetPage(name: '/detecting', page: () => Detecting()), 
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

