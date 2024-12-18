import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  const ImageContainer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   return Container(
    width: 270,
    height: 270,
    child: Image(
       image: NetworkImage(imageUrl),
   ));

  }
}