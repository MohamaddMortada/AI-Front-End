import 'package:flutter/material.dart';

class ElectricTime extends StatefulWidget {
  const ElectricTime({Key? key}) : super(key: key);

  @override
  _ElectricTimeState createState() => _ElectricTimeState();
}

class _ElectricTimeState extends State<ElectricTime> {
  String _time = "Time now"; 

  void _getExactTime() {
   
    final DateTime now = DateTime.now();

    
    final int hour = now.hour;
    final int minute = now.minute;
    final int second = now.second;
    final int millisecond = now.millisecond;

   
    setState(() {
      _time = "Exact Time: $hour:$minute:$second:$millisecond";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Time"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getExactTime,
              child: const Text("Get Device Time"),
            ),
          ],
        ),
      ),
    );
  }
}
