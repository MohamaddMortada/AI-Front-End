import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Text_Field extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;

  const Text_Field(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child:
        Image.asset('assets/Icons/alami.png',width: 50,height: 50,)),

        Container(
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 112, 168, 215),
      ),
      child:  Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),)
      
    ),
    
      ],
    );
  }
}
