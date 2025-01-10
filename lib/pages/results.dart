import 'package:flutter/material.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
    final TextEditingController _trainingController = TextEditingController();

Future<void> sendResult() async {
    final session = _trainingController.text.trim();
    if (session.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid session.")),
      );
      return;
    }

    final url = Uri.parse('http://10.0.2.2:8000/api/setResult'); 
  try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'Result': session}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Session added successfully!")),
        );
        _trainingController.clear();
      } else {
        throw Exception("Failed to add session.");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    } 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Input(text: 'Enter a training session', image: Image.asset('assets/Icons/type.png'), height: 270, maxLines: 10, controller: _trainingController),
              SizedBox(height: 10,),
              ButtonSecondary(text: 'Add Result', image: Image.asset('assets/Icons/add.png'), onTap: (){})
  
            ])));
  }
}
