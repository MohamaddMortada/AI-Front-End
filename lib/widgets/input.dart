
import 'package:flutter/material.dart';
class Input extends StatelessWidget {
   final String text;
   final Icon icon;

   const Input({super.key, required this.text, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 60,
      padding: EdgeInsets.fromLTRB(20,0,20,0),
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:Theme.of(context).secondaryHeaderColor,
      ),
      child: TextFormField(
          decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).secondaryHeaderColor,
          icon: icon,
          labelText: text,
        ),
    ));
  }
}