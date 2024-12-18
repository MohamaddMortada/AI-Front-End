import 'package:flutter/material.dart';
import 'package:front_end/pages/analyze.dart';
import 'package:front_end/pages/analyzing.dart';
import 'package:front_end/pages/calculate.dart';
import 'package:front_end/pages/change_password.dart';
import 'package:front_end/pages/detect.dart';
import 'package:front_end/pages/detecting.dart';
import 'package:front_end/pages/main_page.dart';
import 'package:front_end/pages/predict.dart';
import 'package:front_end/pages/predicting.dart';
import 'package:front_end/widgets/assistive_ball.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return  MaterialApp(
      
      theme: ThemeData(
        primaryColor: Color(0xFF006B8B),
        secondaryHeaderColor:Color(0xFFE1F7FF),
        scaffoldBackgroundColor: Color(0xFFB2C8D0),

      ),
      home:Predicting(),
      
    );
  }
}

