import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlamiMessage extends StatelessWidget {
  late final String text;
  late final FontWeight fontWeight;
  late final double fontSize;

   AlamiMessage(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Row(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child:
        Image.asset('assets/Icons/alami.png',width: 50,height: 50,)),

        Container(
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        //color: Color.fromARGB(255, 112, 168, 215),
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
