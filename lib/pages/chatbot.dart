import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/widgets/input.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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

      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      setState(() {
        messages.add({"role": "bot", "content": "Failed to get response"});
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 139, 166, 177),
              Color.fromARGB(255, 19, 99, 134),
              Color.fromARGB(255, 1, 71, 98),
              Color.fromARGB(255, 0, 41, 57),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundImage: const AssetImage('assets/Chatbot-girl.webp'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Align(
                      alignment: message['role'] == 'user'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: message['role'] == 'user'
                          ? const EdgeInsets.only(top:8,bottom: 8,right: 8, left:50)
                          : const EdgeInsets.only(top:8,bottom: 8,right: 50, left:8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 225, 245, 255),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            message['content'] ?? '',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ));
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Input(
                        text: 'Type your message here!',
                        image: Image.asset('assets/Icons/type.png'),
                        height: 45,
                        maxLines: 1,
                        controller: messageController,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        size: 30,
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final message = messageController.text;
                        if (message.isNotEmpty) {
                          sendMessage(message);
                          messageController.clear();
                        }
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
