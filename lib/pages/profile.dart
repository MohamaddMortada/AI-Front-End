import 'package:flutter/material.dart';
import 'package:front_end/widgets/assistive_ball.dart';
import 'package:front_end/widgets/input.dart';
import 'package:front_end/widgets/profile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _userName = "User";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController pbController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  ProfileIcon(
                    imageUrl: 'https://pics.craiyon.com/2023-10-20/ff5136d14c0f415faa9cd7e7b654a277.webp',
                    rad: 80,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Welcome, $_userName', 
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Input(
                    text: '$_userName',
                    image:  Image.asset('assets/Icons/person.png'),
                    height: 45,
                    maxLines: 1,
                    controller: nameController,
                  ),
                  const SizedBox(height: 10),
                  Input(
                    text: 'Event',
                    image:  Image.asset('assets/Icons/lap.png'),
                    height: 45,
                    maxLines: 1,
                    controller: eventController,
                  ),
                  const SizedBox(height: 10),
                  Input(
                    text: 'Personal Best',
                    image:  Image.asset('assets/Icons/clock.png'),
                    height: 45,
                    maxLines: 1,
                    controller: pbController,
                  ),
                  const SizedBox(height: 10),
                  Input(
                    text: 'Password',
                    image:  Image.asset('assets/Icons/key.png'),
                    height: 45,
                    maxLines: 1,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          AssistiveBall(),
        ],
      ),
    );
  }
}
