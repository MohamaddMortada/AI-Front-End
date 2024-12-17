import 'package:flutter/material.dart';

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
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
