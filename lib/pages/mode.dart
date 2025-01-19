import 'package:flutter/material.dart';
import 'package:front_end/widgets/button.dart';
import 'package:get/get.dart';
import 'package:front_end/widgets/profile_bar.dart';

class ModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  const ProfileBar(),
                  Positioned(
                    left: 10,
                    top: 20, 
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/chronometer.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 40),
                    Main_Button(
                      text: 'Start Line',
                      image: Image.asset('assets/Icons/add.png'),
                      onTap: () {
                        Get.toNamed('/validate');
                      },
                      route: '/validate',
                    ),
                    const SizedBox(height: 20),
                    Main_Button(
                      text: 'Finish Line',
                      image: Image.asset('assets/Icons/add.png'),
                      onTap: () {
                        Get.toNamed('/sync');
                      },
                      route: '/sync',
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3), 
            ],
          ),
        ],
      ),
    );
  }
}
