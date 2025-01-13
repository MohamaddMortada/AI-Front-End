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
              ProfileBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Image.asset(
                      'assets/Icons/alami.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 0),
                    child: Text_Field(
                      text: 'WELCOME $_userName \n to ATHLETIQ',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                ],
              ),
              Spacer(),
            
                  ImageButton(
                    imagePath: 'assets/Detect-Image.webp',
                    text: 'DETECT',
                    discription: 'DETECT & FIX \nERRORS',
                    route: '/detect',
                  ),
                  ImageButton(
                    imagePath: 'assets/Analyze-Image.webp',
                    text: 'ANALYZE',
                    discription: 'ANALYZE YOUR PERFORMANCE',
                    route: '/analyze',
                  ),
                
              SizedBox(height: 50),
              
                  ImageButton(
                    imagePath: 'assets/Predict-Image.webp',
                    text: 'PREDICT',
                    discription: 'PREDICT FUTURE PERFORMANCES',
                    route: '/predict',
                  ),
                  ImageButton(
                    imagePath: 'assets/Calculate-Image.webp',
                    text: 'CALCULATE',
                    discription: 'CALCULATE YOUR \nPOINTS',
                    route: '/calculate',
                  ),
               
              Spacer(),
              Spacer(),
            ],
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
