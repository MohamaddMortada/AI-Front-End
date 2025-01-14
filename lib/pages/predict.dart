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
  List<dynamic> results = [];
  String predictedResult = '';
  String confidence = '';

  Future<void> fetchResults() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/getresult'); 
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id':'2'
          }),);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          results = data['result'];
        });
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

    Future<void> predictResult() async {
    if (results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Input some Results in the results section")),
      );
    }

    final url = Uri.parse('http://10.0.2.2:8000/api/aipredict');
      final response = await http.post(
        url,
        body: {
          'results': json.encode(results), 
          'event':eventController.text.trim()
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          predictedResult = data['prediction'];
          confidence = data['confidence'].toString();
        });
      } else {
        throw Exception('Failed to get prediction');
      }
   
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
        children: [
           Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: [
                  ProfileBar(),
                  Image.asset('assets/finishh.png',width: 300,height: 300,),
                  Spacer(),
                  AlamiMessage(text: 'Wanna know how much you can run right now!?', fontSize: 14, fontWeight: FontWeight.w500),
                  SizedBox(height: 10,),
                  Text(results.toString()),
                  SizedBox(height: 10,),
                  Input(text: 'Event',image: Image.asset('assets/Icons/lap.png'), height: 45, maxLines: 1, controller: eventController,),
                  SizedBox(height: 10,),
                  ButtonSecondary(text: '',  image:  Image.asset('assets/Icons/add.png'),onTap: () { predictResult();},),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                ]
              )
          ),
          AssistiveBall(),
  ]));
  }
}
