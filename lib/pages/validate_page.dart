import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/widgets/profile_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:front_end/widgets/button_secondary.dart';

class ValidatePage extends StatefulWidget {
  @override
  _ValidatePageState createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  final TextEditingController _keyController = TextEditingController();
  bool isValidated = false;

  Future<void> storeSyncKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sync_key', key);
  }

  Future<void> validateKey(String key) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.170:8000/api/validate-key'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'sync_key': key, 'user_id': '5'}),
      );

      if (response.statusCode == 200) {
        setState(() {
          isValidated = true;
        });
        await storeSyncKey(key);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Key validated successfully!")),
        );
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(data['error'] ?? "Invalid key. Please try again.")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Error validating key. Please check your connection.")),
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
                'Key Validator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/validatekey.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _keyController,
                decoration: const InputDecoration(
                  labelText: "Enter Sync Key",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ButtonSecondary(
                text: "Validate Key",
                image: Image.asset('assets/Icons/white-lock.png'),
                onTap: () async {
                  final key = _keyController.text.trim();
                  if (key.isNotEmpty) {
                    await validateKey(key);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a key.")),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              ButtonSecondary(
                text: "Scan QR Code",
                image: Image.asset('assets/Icons/qr.png'),
                onTap: () async {
                  final qrCode = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QRCodeScannerPage()),
                  );
                  if (qrCode != null) {
                    _keyController.text = qrCode;
                  }
                },
              ),
              const SizedBox(height: 10),
              if (isValidated)
                ButtonSecondary(
                  text: "Get to Start Line",
                  image: Image.asset('assets/Icons/start.png'),
                  onTap: () {
                    Get.toNamed('/start_line');
                  },
                ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      qrController = qrViewController;
    });
    qrController?.scannedDataStream.listen((scanData) {
      qrController?.pauseCamera();
      Navigator.pop(context, scanData.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
