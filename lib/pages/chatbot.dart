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
        body: 
          
Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:Color.fromARGB(255, 201, 218, 223),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(message['content'] ?? ''),
                  ),
                );
              },
            ),
          ),]));
      }
}

  
    