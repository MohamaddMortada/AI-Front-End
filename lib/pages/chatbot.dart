import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_widget.dart';

class Chatbot extends StatelessWidget {
    
    final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
        body: Stack(
          
          children: [
            
            Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 50,),
          ProfileIcon(
            imageUrl:'https://static.vecteezy.com/system/resources/previews/023/124/665/large_2x/modern-futuristic-female-humanoid-robot-portrait-with-technology-details-on-face-neural-network-generated-art-photo.jpg' ,
            rad: 80,
          ),
          Spacer(),
          Align(
            alignment:Alignment.bottomCenter,
            child:Input(
              
              text: 'Type your message here!', icon: Icon(Icons.type_specimen), height: 45, maxLines: 1, controller: messageController,
              ),
              
            ),
            SizedBox(height: 10,),
          ]
             
         )
          )]));
      }
    }