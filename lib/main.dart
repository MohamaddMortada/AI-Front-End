

import 'package:flutter/material.dart';
import 'package:front_end/controllers/routes.dart';
import 'package:front_end/pages/login.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return  GetMaterialApp(
      initialRoute: '/',  
      getPages: appRoutes,
      theme: ThemeData(
        primaryColor: Color(0xFF006B8B),
        secondaryHeaderColor:Color(0xFFE1F7FF),
        scaffoldBackgroundColor: Color(0xFFB2C8D0),

      ),
      home:Login(),
      
    );
  }
}

