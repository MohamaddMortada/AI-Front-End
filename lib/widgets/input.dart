
import 'package:flutter/material.dart';
class Input extends StatelessWidget {
   final String text;
   final Icon icon;
   final double height;
   final int maxLines;

   const Input({super.key, required this.text, required this.icon, required this.height, required this.maxLines});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: height,
      padding: EdgeInsets.fromLTRB(20,0,20,0),
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Theme.of(context).secondaryHeaderColor,
      ),
      child: TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).secondaryHeaderColor,
          icon: icon,
          labelText: text,
        ),
    ));
  }
}