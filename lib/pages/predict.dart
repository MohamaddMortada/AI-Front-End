import 'package:flutter/material.dart';
import 'package:front_end/widgets/alami_message.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Predict extends StatefulWidget {
  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  final TextEditingController eventController = TextEditingController();
  List<String> results = []; 
  String predictedResult = '';
  String confidence = '';
  bool isLoading = false;

  Future<void> fetchResults() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://192.168.44.188:8000/api/getresult'); 

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': '33'}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'] != null && data['results'] is List) {
          setState(() {
            results = List<String>.from(data['results'].map((item) => item['result'].toString()));
          });
        } else {
          throw Exception('Results not found');
        }
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> predictResult() async {
    await fetchResults();
    if (results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Input some results in the results section")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://192.168.44.188:8000/api/aipredict');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'results': results, 
          'event': eventController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          predictedResult = data['prediction'] ?? ''; 
          confidence = data['confidence']?.toString() ?? ''; 
        });
      } else {
        throw Exception('Failed to get prediction');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileBar(),
                Image.asset(
                  'assets/finishh.png',
                  width: 300,
                  height: 300,
                ),
                Spacer(),
                AlamiMessage(
                    text: 'Wanna know how much you can run right now!?',
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                SizedBox(height: 10),
                /*Text(
                  results.isEmpty
                      ? 'No results yet'
                      : 'Results: ${results.join(', ')}', 
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),*/
                SizedBox(height: 10),
                Input(
                  text: 'Event',
                  image: Image.asset('assets/Icons/lap.png'),
                  height: 45,
                  maxLines: 1,
                  controller: eventController,
                ),
                SizedBox(height: 10),
                ButtonSecondary(
                  text: '',
                  image: Image.asset('assets/Icons/add.png'),
                  onTap: predictResult,
                ),
                if (isLoading) CircularProgressIndicator(),
                SizedBox(height: 20),
                if (predictedResult.isNotEmpty)
                  Text('Prediction: $predictedResult'),
                if (confidence.isNotEmpty)
                  Text('Confidence: $confidence'),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
