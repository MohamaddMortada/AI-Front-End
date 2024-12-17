import 'package:flutter/material.dart';
class Main_Button extends StatelessWidget {
  final String text;

  const Main_Button({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
   
   return ElevatedButton(
    style: ElevatedButton.styleFrom(
            
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white, 
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
          ),
    ),
    onPressed: () {
            print("Styled Button Pressed!");
          }, 
    child: Text(text),
    );
  }
} 