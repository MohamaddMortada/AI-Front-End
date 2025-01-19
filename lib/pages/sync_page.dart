import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SyncPage extends StatefulWidget {
  @override
  _SyncPageState createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  String syncKey = "";

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

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('sync_key', syncKey);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync Key generated and saved!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate Sync Key')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  const ProfileBar(),
                  Positioned(
                    left: 10,
                    top: 20, 
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                'Key Generator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/synckey.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 40),
              if (syncKey.isNotEmpty)
                Text(
                  "Sync Key: $syncKey",
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 20),
              if (syncKey.isNotEmpty)
                Container(
                  color: const Color.fromARGB(255, 110, 168, 187),
                  child: QrImageView(
                    data: syncKey,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              const SizedBox(height: 20),
              ButtonSecondary(
                  text: "Generate Key",
                  image: Image.asset('assets/Icons/white-key.png'),
                  onTap: () async {
                    await generateKey();
                  }),
              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
