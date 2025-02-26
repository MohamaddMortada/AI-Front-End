import 'package:flutter/material.dart';
import 'package:front_end/widgets/alami_message.dart';
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
    final url = Uri.parse('http://192.168.43.170:5000/get_id');

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
    }
  }

  Future<void> fetchScore() async {
    if (_fetchedId == null || resultController.text.isEmpty) {
      setState(() {
        scoreController.text = 'Error: Missing Id or Result';
        _isLoading = false;
      });
      return;
    }

    final url = Uri.parse('https://athleticsranking.vercel.app/ranking/points');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "eventId": _fetchedId,
          "performance": resultController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        setState(() {
          scoreController.text = responseData['performancePoints'].toString();
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Container(
                  alignment: Alignment.center,
                  width: isSmallScreen ? screenWidth * 0.8 : 250,
                  height: isSmallScreen ? 50 : 60,
                  child: const Text(
                    'Athletic Performance\n Calculator',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset('assets/group-run.png',
                    height: isSmallScreen ? 150 : 200,
                    width: isSmallScreen ? 150 : 200),
                const Spacer(),
                AlamiMessage(
                  text: 'Check your Points Right Now!',
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 20 : 30),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Choose Stadium'),
                      Row(
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
                          SizedBox(width: screenWidth * 0.05),
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
                      const Text('Choose Gender'),
                      Row(
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
                          Image.asset('assets/Icons/male.png',
                              height: isSmallScreen ? 30 : 40,
                              width: isSmallScreen ? 30 : 40),
                          SizedBox(width: screenWidth * 0.05),
                          Radio<String>(
                            value: 'w',
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          Image.asset('assets/Icons/female.png',
                              height: isSmallScreen ? 30 : 40,
                              width: isSmallScreen ? 30 : 40),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  width: isSmallScreen ? screenWidth * 0.85 : 330,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
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
                        child: Text('$event m'),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedEvent = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Input(
                  text: 'Result',
                  image: Image.asset('assets/Icons/clock.png'),
                  height: isSmallScreen ? 40 : 45,
                  maxLines: 1,
                  controller: resultController,
                ),
                const SizedBox(height: 20),
                ButtonSecondary(
                  text: 'Calculate',
                  image: Image.asset('assets/Icons/calculate.png'),
                  onTap: () async {
                    await fetchEventId();
                    await fetchScore();
                  },
                ),
                const SizedBox(height: 10),
                if (_isLoading)
                  const CircularProgressIndicator(),
                if (!_isLoading)
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 40,
                    child: Text(
                      scoreController.text,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const ProfileBar(),
              ],
            ),
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
