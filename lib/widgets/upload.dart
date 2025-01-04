import 'package:flutter/material.dart';
class Upload extends StatelessWidget {
final VoidCallback onTap;
  const Upload({required this.onTap});

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
    height: 270,
      child:const Column(
        mainAxisAlignment : MainAxisAlignment.center,
        crossAxisAlignment : CrossAxisAlignment.center,
        children: [
            Icon(
                Icons.upload, 
                size: 100, 
                color: Colors.white, 
              ),
            
            Text('Upload', 
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              ),)
          ],
      ),));
   
   
  }
} 