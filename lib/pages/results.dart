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

    final url = Uri.parse('http://10.0.2.2:8000/api/results');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'result': session, 'user_id': 2}),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Session added successfully!")),
        );
        _trainingController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Failed to add session. Status: ${response.statusCode}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Unable to connect to server.")),
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
            const Spacer(),
            const Text(
              'Sessions Section',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/results.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Input(
              text: 'Enter a training session/result',
              image: Image.asset('assets/Icons/type.png'),
              height: 150,
              maxLines: 6,
              controller: _trainingController,
            ),
            const SizedBox(height: 20),
            ButtonSecondary(
              text: 'Add Result',
              image: Image.asset('assets/Icons/add.png'),
              onTap: sendResult,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
