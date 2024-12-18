import 'package:flutter/material.dart';
import 'package:front_end/widgets/profile_widget.dart';

class ProfileBar extends StatelessWidget {
  
  
  const ProfileBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   return Container(
      child:const Align(
                alignment: Alignment.topRight,
                  child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: ProfileIcon(imageUrl: 'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp', rad: 24),

              ),),
        );
   
  }
}