import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Main_Button extends StatelessWidget {
  final String text;
  final Icon icon;

  const Main_Button({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
   
   return GestureDetector(
            onTap: () {
              print('Clicked');
            },
            child:Container(
      decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10)
    ),
    width:270,
    height: 45,
      child: Row(
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        crossAxisAlignment : CrossAxisAlignment.center,
        children: [
            icon,
            Text(
              text, 
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              ),),
              const SizedBox(width: 30,),
          ],
      ),));
  
  }
} 