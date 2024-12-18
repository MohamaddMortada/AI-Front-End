import 'package:flutter/material.dart';
import 'package:front_end/widgets/text_field.dart';
class ImageButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final String discription;
  const ImageButton({super.key, required this.imagePath, required this.text, required this.discription});

  @override
  Widget build(BuildContext context) {
   
   return GestureDetector(
            onTap: () {
              print('Clicked');
            },
            child:
            Container(
      decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10)
    ),

    width:160,
    height: 220,
    padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Column(
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 40,
            child: Text_Field(text: discription, fontSize: 12, fontWeight: FontWeight.w800),),
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