import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:get/get.dart';

class ModePage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: 20),
            Main_Button(text: 'Start Line', image: Image.asset('assets/Icons/add.png'), onTap: (){Get.toNamed('/validate');}, route: '/validate',),
            SizedBox(height: 20),
            Main_Button(text: 'Finish Line', image: Image.asset('assets/Icons/add.png'), onTap: (){Get.toNamed('/sync');},route:'/sync'),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
