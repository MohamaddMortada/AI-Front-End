import 'package:flutter/material.dart';

class Voice extends StatelessWidget {
  const Voice({super.key});

  @override
  Widget build(BuildContext context) {
   
   return Container(
            width: 270,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.voice_chat),
            
            ),);
  }
}