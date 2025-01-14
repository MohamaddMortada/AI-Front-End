import 'dart:io';

import 'package:flutter/material.dart';
class Upload extends StatelessWidget {
final VoidCallback onTap;
final File? media;
  const Upload({required this.onTap, this.media});

  @override
  Widget build(BuildContext context) {
   
   return GestureDetector(
            onTap: onTap,
            child:Container(
      decoration: BoxDecoration(
      /*image: media != null
                  ? DecorationImage(
                      image: FileImage(media!), 
                      fit: BoxFit.contain,
                    )
                  : null,*/
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10)
    ),
    width:330,
    height: 45,
      child: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        crossAxisAlignment : CrossAxisAlignment.center,
        children: [
          //if(media == null)
            /*Icon(
                Icons.upload, 
                size: 10, 
                color: Colors.white, 
              ),*/
            //if(media == null)
            Text('Upload an Image/Video', 
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              ),)
          ],
      ),));
   
   
  }
} 