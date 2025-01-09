import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_widget.dart';
import 'package:http/http.dart' as http;


class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {  
    final TextEditingController messageController = TextEditingController();
     List<Map<String, String>> messages = [];

     Future<void> sendMessage(String message) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/chatbot'); 
    final response = await http.post(
      url,
      body: {'message': message},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        messages.add({"role": "user", "content": message});
        messages.add({"role": "bot", "content": data['response']});
      });
    } else {
      setState(() {
        messages.add({"role": "bot", "content": "Failed to get response"});
      });
    }
  }


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
              
              text: 'Type your message here!', image: Image.asset('assets/Icons/type.png'), height: 45, maxLines: 1, controller: messageController,
              ),
              
            ),
            SizedBox(height: 10,),
          ]
             
         )
          )]));
      }
}

  
    