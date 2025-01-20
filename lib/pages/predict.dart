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

    final url = Uri.parse('http://192.168.199.124:8000/api/getresult');

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
            results = List<String>.from(
                data['results'].map((item) => item['result'].toString()));
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
        const SnackBar(
            content: Text("Input some results in the results section")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://192.168.199.124:8000/api/aipredict');

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
                const ProfileBar(),
                const Text(
                  'PREDICT',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  'assets/finishh.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                const Spacer(),
                AlamiMessage(
                    text: 'Wanna know how much you can run right now!?',
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                const SizedBox(height: 10),
                /*Text(
                  results.isEmpty
                      ? 'No results yet'
                      : 'Results: ${results.join(', ')}', 
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),*/
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Input(
                    text: 'Event',
                    image: Image.asset('assets/Icons/lap.png'),
                    height: 45,
                    maxLines: 1,
                    controller: eventController,
                  ),
                ),
                const SizedBox(height: 10),
                ButtonSecondary(
                  text: 'PREDICT',
                  image: Image.asset('assets/Icons/predict.png'),
                  onTap: predictResult,
                ),
                const SizedBox(height: 10),
                if (isLoading) const CircularProgressIndicator(),
                const SizedBox(height: 20),
                if (!isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          'Prediction:\n $predictedResult',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Confidence:\n $confidence',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
