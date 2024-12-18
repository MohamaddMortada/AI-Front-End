import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String imageUrl;
  final double rad;
  
  const ProfileIcon({Key? key, required this.imageUrl, required this.rad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   return CircleAvatar(
      radius: rad,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}