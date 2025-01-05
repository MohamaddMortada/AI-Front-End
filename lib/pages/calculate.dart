import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final TextEditingController resultController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();

  final List<String> events = [
    '100',
    '200',
    '400',
    '110h',
    '400h',
    '800',
    '1000',
    '1500',
    '3000',
    '3000st',
    '5000',
    '10000',
    '21.1k',
    '42.2k'
  ];

  String _selectedEvent = '100';
  String? _selectedGender = 'Male';
  String? _selectedStadium = 'Indoor';

  String? _fetchedId;
  bool _isLoading = false;

  Future<void> fetchEventId() async {
    final url = Uri.parse('http://10.0.2.2:5000/get_id');

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "Name": _selectedEvent,
          "Type": _selectedStadium,
          "Gender": _selectedGender,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _fetchedId = responseData['Id'];
        });
      } else {
        setState(() {
          _fetchedId = 'Error: Event not found';
        });
      }
    } catch (error) {
      setState(() {
        _fetchedId = 'Error: Unable to connect to API';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchScore() async {
    if (_fetchedId == null || resultController.text.isEmpty) {
      setState(() {
        scoreController.text = 'Error: Missing Id or Result';
      });
      return;
    }

    final url = Uri.parse('https://athleticsranking.vercel.app/ranking/points'); 

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "Id": _fetchedId,
          "Result": resultController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          scoreController.text = responseData['Score'].toString();
        });
      } else {
        setState(() {
          scoreController.text = 'Error: Unable to fetch score';
        });
      }
    } catch (error) {
      setState(() {
        scoreController.text = 'Error: Unable to connect to API';
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
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'i',
                      groupValue: _selectedStadium,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedStadium = value;
                        });
                      },
                    ),
                    const Text('Indoor'),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: 'o',
                      groupValue: _selectedStadium,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedStadium = value;
                        });
                      },
                    ),
                    const Text('Outdoor'),
                  ],
                ),
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
                      value: 'm',
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
                      value: 'f',
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
                const SizedBox(height: 10),
                Input(
                  text: 'Result',
                  icon: const Icon(Icons.lock_clock),
                  height: 45,
                  maxLines: 1,
                  controller: resultController,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await fetchEventId();
                    await fetchScore(); 
                  },
                  child: const Text('Calculate'),
                ),
                const SizedBox(height: 10),
                Input(
                  text: 'Score',
                  icon: const Icon(Icons.score),
                  height: 45,
                  maxLines: 1,
                  controller: scoreController,
                ),
                Text('$_fetchedId'),
                Text('$_selectedEvent'),
                Text('$_selectedGender'),
                Text('$_selectedStadium'),

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
