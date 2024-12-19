import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class IconItem extends StatelessWidget {
  final String route;
  final IconData icon;


  const IconItem({super.key, required this.route, required this.icon});

  @override
  Widget build(BuildContext context) {
   
   return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: 
      GestureDetector(
            onTap: () {
              Get.toNamed(route);
            },
            child: Icon(icon, color: Colors.white, size: 35),
      ),
    );
  }}
  