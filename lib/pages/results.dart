import 'package:flutter/material.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final TextEditingController _trainingController = TextEditingController();
  List<dynamic> _results = []; 

  @override
  void initState() {
    super.initState();

     fetchResults();
  }  



  Future<void> fetchResults() async {
    final url = Uri.parse('http://192.168.44.188:8000/api/getresult');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': 33}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _results = data['results'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to fetch results. Status: ${response.statusCode}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Unable to connect to server.")),
      );
    }
  }

  Future<void> sendResult() async {
    final session = _trainingController.text.trim();
    if (session.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid session.")),
      );
      return;
    }

    final url = Uri.parse('http://192.168.44.188:8000/api/results');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'result': session, 'user_id': 33}),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Session added successfully!")),
        );
        _trainingController.clear();
        fetchResults();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add session. Status: ${response.statusCode}")),
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
      body: Column(
        children: [
          const SizedBox(height: 40), 
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Input(
              text: 'Enter a training session/result',
              image: Image.asset('assets/Icons/type.png'),
              height: 150,
              maxLines: 6,
              controller: _trainingController,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonSecondary(
              text: 'Add Result',
              image: Image.asset('assets/Icons/add.png'),
              onTap: sendResult,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 2, 
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _results.isEmpty
                  ? const Center(
                      child: Text("No results available."),
                    )
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final result = _results[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text('Session: ${result['result']}'),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
