import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/widgets/button.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidatePage extends StatefulWidget {
  @override
  _ValidatePageState createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  final TextEditingController _keyController = TextEditingController();
  int? timeDifference;
  bool isValidated = false;

  Future<void> storeSyncKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sync_key', key); 
  }

  Future<String?> getSyncKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('sync_key'); 
  }

  Future<void> validateKey(String key) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.44.188:8000/api/validate-key'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'sync_key': key, 'user_id': '5'}),
      );

      if (response.statusCode == 200) {
        setState(() {
          isValidated = true;
        });
        await storeSyncKey(key);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Key validated successfully!")));
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data['error'] ?? "Invalid key. Please try again.")));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error validating key. Please check your connection.")));
    }
  }

  Future<void> stopSession(String key) async {
    final response = await http.post(
      Uri.parse('http://192.168.44.188:8000:8000/api/stop'),
      body: {'sync_key': key},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        timeDifference = data['time_difference'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (timeDifference != null)
              Text("Time Difference: $timeDifference seconds",
                  style: const TextStyle(fontSize: 18)),
            TextField(
              controller: _keyController,
              decoration: InputDecoration(
                labelText: "Enter Sync Key",
                border: OutlineInputBorder(),
              ),
            ),
            ButtonSecondary(
              text: "Validate Key",
              image: Image.asset('assets/Icons/add.png'),
              onTap: () async {
                final key = _keyController.text.trim();
                if (key.isNotEmpty) {
                  await validateKey(key);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a key.")),
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            if(isValidated)
            ButtonSecondary(
              text: "Get to Start Line",
              image: Image.asset('assets/Icons/add.png'),
              onTap: () {
                Get.toNamed('/start_line');
              },
            ),
            const SizedBox(
              height: 10,
            ),
           
          ],
        ),
      )),
    );
  }
}
