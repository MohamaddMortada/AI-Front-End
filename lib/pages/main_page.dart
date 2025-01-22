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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    padding: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Image.asset(
                      'assets/Icons/alami.png',
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.02),
                    child: Text_Field(
                      text: 'WELCOME $_userName \n to ATHLETIQ',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.05),
                  children: [
                    const ImageButton(
                      imagePath: 'assets/Detect-Image.webp',
                      text: 'DETECT',
                      discription: 'DETECT & FIX \nERRORS',
                      route: '/detect',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const ImageButton(
                      imagePath: 'assets/Analyze-Image.webp',
                      text: 'PHOTO FINISH',
                      discription: 'LIVE PHOTO \nFINISH TIMING',
                      route: '/mode',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const ImageButton(
                      imagePath: 'assets/Predict-Image.webp',
                      text: 'PREDICT',
                      discription: 'PREDICT FUTURE \nPERFORMANCES',
                      route: '/predict',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const ImageButton(
                      imagePath: 'assets/Calculate-Image.webp',
                      text: 'CALCULATE',
                      discription: 'CALCULATE YOUR \nPOINTS',
                      route: '/calculate',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const ImageButton(
                      imagePath: 'assets/session.webp',
                      text: 'SESSIONS',
                      discription: 'Add Your Daily \nSessions',
                      route: '/results',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const ImageButton(
                      imagePath: 'assets/Chatbot-girl.webp',
                      text: 'CHATBOT',
                      discription: 'Have you Meet \nMika?',
                      route: '/chatbot',
                    ),
                  ],
                ),
              ),
            ],
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
