import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/image_button.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:front_end/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _userName = "User";

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ProfileBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Image.asset(
                      'assets/Icons/alami.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text_Field(
                      text: 'WELCOME $_userName \n to ATHLETIQ',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              const ImageButton(
                imagePath: 'assets/Detect-Image.webp',
                text: 'DETECT',
                discription: 'DETECT & FIX \nERRORS',
                route: '/detect',
              ),
              const SizedBox(height: 10),
              const ImageButton(
                imagePath: 'assets/Analyze-Image.webp',
                text: 'ANALYZE',
                discription: 'ANALYZE YOUR PERFORMANCE',
                route: '/analyze',
              ),
              const SizedBox(height: 10),
              const ImageButton(
                imagePath: 'assets/Predict-Image.webp',
                text: 'PREDICT',
                discription: 'PREDICT FUTURE PERFORMANCES',
                route: '/predict',
              ),
              const SizedBox(height: 10),
              const ImageButton(
                imagePath: 'assets/Calculate-Image.webp',
                text: 'CALCULATE',
                discription: 'CALCULATE YOUR \nPOINTS',
                route: '/calculate',
              ),
              const SizedBox(height: 10),
              const ImageButton(
                imagePath: 'assets/Calculate-Image.webp',
                text: 'SESSIONS',
                discription: 'Add Your Daily \nSessions',
                route: '/results',
              ),
              const SizedBox(height: 10),
              const ImageButton(
                imagePath: 'assets/Chatbot-girl.webp',
                text: 'CHATBOT',
                discription: 'Have you Meet Mika? \n',
                route: '/chatbot',
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
