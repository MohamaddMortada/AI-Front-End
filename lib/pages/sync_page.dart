import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SyncPage extends StatefulWidget {
  @override
  _SyncPageState createState() => _SyncPageState();
}
class _SyncPageState extends State<SyncPage> {

  String syncKey = "";

  Future<void> generateKey() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/generate-key'),
      body: {'user_id': '2'},
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      setState(() {
        syncKey = data['sync_key'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}