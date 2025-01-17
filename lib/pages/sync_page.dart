import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:front_end/widgets/button_secondary.dart';

class SyncPage extends StatefulWidget {
  @override
  _SyncPageState createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {

  String syncKey = "";
  int? timeDifference;

  Future<void> _saveSyncKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sync_key', key);  
  }

  Future<void> generateKey() async {
    final response = await http.post(
      Uri.parse('http://192.168.199.124:8000/api/generate-key'),
      body: {'user_id': '2'},
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      setState(() {
        syncKey = data['sync_key'];
      });

      await _saveSyncKey(syncKey);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sync Key generated and saved!'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate Sync Key'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sync Key: $syncKey", style: const TextStyle(fontSize: 18)),
              if (timeDifference != null)
                Text("Time Difference: $timeDifference seconds", style: const TextStyle(fontSize: 18)),

              ButtonSecondary(
                text: "Generate Key",
                image: Image.asset('assets/Icons/add.png'),
                onTap: () async {
                  await generateKey();
                },
              ),
              const SizedBox(height: 10),
              if(syncKey != '')
              ButtonSecondary(
                text: "Get to finish line",
                image: Image.asset('assets/Icons/add.png'),
                onTap: () {
                  Get.toNamed('/analyze');
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
