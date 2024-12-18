import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/upload.dart';

class Detect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
            ProfileBar(),
            Spacer(),
            Upload(),
            SizedBox(height: 10,),
            Main_Button(text: 'Detect', icon: Icon(Icons.error)),
            Spacer(),
            Spacer(),
          ]),
        
      ),
    );
  }
}
