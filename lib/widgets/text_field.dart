
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Text_Field extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  
  const Text_Field({super.key, required this.text, required this.fontSize,required this.fontWeight});

  @override
  Widget build(BuildContext context) {
   
   return Container(
    width: 300,
        child:Text(
          text,
          textAlign:TextAlign.center,
          style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
         ),
      )
   );
  }
}