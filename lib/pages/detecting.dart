import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/widgets/image_container.dart';
import 'package:front_end/widgets/voice.dart';

class Detecting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [

          Spacer(),
          ImageContainer(imageUrl: 'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp'),
          SizedBox(height: 20,),
          Voice(),
          ImageContainer(imageUrl: 'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp'),
          Spacer(),
        ])));}}