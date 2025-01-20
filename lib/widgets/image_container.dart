import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  const ImageContainer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   return Container(
    color: Theme.of(context).primaryColor,
    width: 270,
    height: 270,
    child: Image.network(imageUrl),
   );

  }
}