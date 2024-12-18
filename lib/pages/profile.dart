import 'package:flutter/material.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_widget.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              ProfileIcon(imageUrl: 'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp', rad: 80,),
              SizedBox(height: 50),
              Input(text: 'Username', icon: Icon(Icons.person), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Event', icon: Icon(Icons.event), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Personal Best', icon: Icon(Icons.lock_clock), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Input(text: 'Password', icon: Icon(Icons.key), height: 45, maxLines: 1),
              SizedBox(height: 10),
              Spacer(),Spacer(),
            ]
          )
        )
    );
  }
}