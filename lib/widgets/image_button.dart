import 'package:flutter/material.dart';
class ImageButton extends StatelessWidget {
  final String imagePath;
  final String text;
  const ImageButton({super.key, required this.imagePath, required this.text});

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
                imagePath,
                width:double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),

            Text(text, 
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
              ),
            ),
          ],
      ),));
   
   
   }}