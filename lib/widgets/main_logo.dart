import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   return CircleAvatar(
    radius: 120,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    backgroundImage: const AssetImage('assets/Logo.png'),
   );

  }
}