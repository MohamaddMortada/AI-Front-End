import 'package:flutter/material.dart';

class AssistiveBall extends StatelessWidget {


  Widget IconItem(IconData icon, String tooltip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Tooltip(
        message: tooltip,
        child: Icon(icon, color: Colors.white, size: 35),
      ),
    );
  }
  
    Widget _buildIconsColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconItem(Icons.home, "Home"),
        IconItem(Icons.chat, "AI Chatbot"),
        IconItem(Icons.person, "Profile"),
        IconItem(Icons.email_outlined, "Contact Us"),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
