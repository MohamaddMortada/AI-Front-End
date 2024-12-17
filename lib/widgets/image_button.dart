import 'package:flutter/material.dart';
class ImageButton extends StatelessWidget {

  const ImageButton({super.key});

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

    width:160,
    height: 173,
    padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Column(
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        children: [
            Image.asset(
                'assets/Detect-Image.webp',
                width:double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),

            Text('Detect', 
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
              ),
            ),
          ],
      ),));
   
   
   }}