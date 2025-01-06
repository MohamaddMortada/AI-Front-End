import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class Main_Button extends StatelessWidget {
  final String text;
  final Image image;
  final VoidCallback onTap;
  final String route;

  const Main_Button({super.key, required this.text, required this.image, required this.route, required this.onTap});

  @override
  Widget build(BuildContext context) {
   
   return GestureDetector(
            onTap: onTap,
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
            SizedBox(
            width: 24,
            height: 24,
            child: image,
          ),
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