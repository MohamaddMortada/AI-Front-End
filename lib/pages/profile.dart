import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_widget.dart';

class Profile extends StatelessWidget {
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController pbController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
        children: [
           Center(
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              ProfileIcon(imageUrl: 'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp', rad: 80,),
              SizedBox(height: 50),
              Input(text: 'Username', image: Image.asset('assets/Icons/person.png'), height: 45, maxLines: 1, controller: nameController,),
              SizedBox(height: 10),
              Input(text: 'Event', image: Image.asset('assets/Icons/lap.png'), height: 45, maxLines: 1, controller: eventController,),
              SizedBox(height: 10),
              Input(text: 'Personal Best', image: Image.asset('assets/Icons/clock.png'), height: 45, maxLines: 1, controller: pbController,),
              SizedBox(height: 10),
              Input(text: 'Password', image: Image.asset('assets/Icons/key.png'), height: 45, maxLines: 1, controller: passwordController,),
              SizedBox(height: 10),
              Spacer(),Spacer(),
            ]
          )
        ),
        AssistiveBall()])
    );
  }
}