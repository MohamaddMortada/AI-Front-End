import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_bar.dart';

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final TextEditingController resultController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();

  final List<String> events = [
    '100m', '200m', '400m', '110mh', '400mh', '800m', '1000m', '1500m',
    '3000m', '3000m st', '5000m', '10000m', '21.1k', '42.2k'
  ];

  String _selectedEvent = '100m'; 
  String? _selectedGender = 'Male';

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
                const Spacer(),

                Container(
                  alignment: Alignment.center,
                  width: 270,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: Theme.of(context).primaryColor,
                    dropdownColor: Theme.of(context).primaryColor,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    value: _selectedEvent,
                    items: events.map((String event) {
                      return DropdownMenuItem<String>(
                        value: event,
                        child: Text(event),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedEvent = newValue!;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const Text('Male'),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Input(
                  text: 'Result',
                  icon: const Icon(Icons.lock_clock),
                  height: 45,
                  maxLines: 1,
                  controller: resultController,
                ),
                const SizedBox(
                  height: 10,
                ),
                
                const ButtonSecondary(
                    text: 'Calculate', icon: Icon(Icons.calculate)),
                const SizedBox(
                  height: 10,
                ),

                Input(
                  text: 'Score',
                  icon: const Icon(Icons.score),
                  height: 45,
                  maxLines: 1,
                  controller: scoreController,
                ),
                const Spacer(),
              ],
            ),
          ),
          AssistiveBall()
        ],
      ),
    );
  }
}
