import 'package:flutter/material.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';

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
        const SnackBar(content: Text("Please enter a valid training session.")),
      );
      return;
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
