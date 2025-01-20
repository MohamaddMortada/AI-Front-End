import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileIcon extends StatelessWidget {
  final String imageUrl;
  final double rad;
  
  const ProfileIcon({Key? key, required this.imageUrl, required this.rad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   return GestureDetector(
            onTap: () {
              Get.toNamed('/profile');
            },
            child:CircleAvatar(
      radius: rad,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: NetworkImage(imageUrl),
    ));
  }
}