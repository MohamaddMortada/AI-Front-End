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
    return Container(
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 112, 168, 215),
      ),
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          )),
    );
  }
}
