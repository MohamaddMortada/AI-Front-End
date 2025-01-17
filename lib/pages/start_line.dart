import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StartLine extends StatefulWidget {
  @override
  _StartLineState createState() => _StartLineState();
}

class _StartLineState extends State<StartLine> {
  bool _isButtonDisabled = false;
  bool _showStopButton = false; 
  final String userId = '3';
  late DateTime fireTimestamp;
  String formattedFireTimestamp = '';
  final int delay = 2; 
  late String syncKey;
  @override
  void initState() {
    super.initState();
    _getSyncKey(); 
  }
   Future<void> _getSyncKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      syncKey = prefs.getString('sync_key') ?? ''; 
    });
  }
  Future<void> _handleStartButton() async {
    setState(() {
      _isButtonDisabled = true;
      _showStopButton = true; 
    });

    await Future.delayed(Duration(seconds: delay));

    fireTimestamp = DateTime.now();
    formattedFireTimestamp = fireTimestamp.toString(); 

    setState(() {});

    final response = await http.post(
      Uri.parse('http://192.168.44.188:8000/api/start'), 
      headers: {'Content-Type': 'application/json'},
      body: '{"user_id": "$userId", "fire_timestamp": "$fireTimestamp", "sync_key": "$syncKey"}',
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session Started'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to start session'))
      );
    }

    setState(() {
      _isButtonDisabled = false;
    });
  }

  void _handleStopButton() {
    setState(() {
      formattedFireTimestamp = ''; 
      fireTimestamp = DateTime.now(); 
      _isButtonDisabled = false;
      _showStopButton = false; 
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Session Stopped and Reset'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isButtonDisabled ? null : _handleStartButton,
              child: Text('Start'),
            ),
            SizedBox(height: 20),
            if (_showStopButton) 
              ElevatedButton(
                onPressed: _handleStopButton,
                child: Text('Stop'),
              ),
            SizedBox(height: 20),
            Text(
              formattedFireTimestamp.isEmpty
                  ? 'No timestamp yet'
                  : 'Fire Timestamp: $formattedFireTimestamp',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
