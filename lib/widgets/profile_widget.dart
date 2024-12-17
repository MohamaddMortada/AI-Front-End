import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String imageUrl;
  
  const ProfileIcon({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   return CircleAvatar(
      radius: 24,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}