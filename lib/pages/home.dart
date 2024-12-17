import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Main_Button(text: 'hello',)
      ),
    );
  }
}
