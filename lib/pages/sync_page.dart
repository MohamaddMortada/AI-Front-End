import 'dart:convert';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SyncPage extends StatefulWidget {
  @override
  _SyncPageState createState() => _SyncPageState();
}
class _SyncPageState extends State<SyncPage> {

  String syncKey = "";
  int? timeDifference;

  Future<void> generateKey() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/generate-key'),
      body: {'user_id': '2'},
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      setState(() {
        syncKey = data['sync_key'];
      });
    }
  }

    Future<void> startSession() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/start'),
      body: {'sync_key': syncKey},
    );

    if (response.statusCode == 200) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (syncKey.isNotEmpty)
              Text("Sync Key: $syncKey", style: const TextStyle(fontSize: 18)),
            if (timeDifference != null)
              Text("Time Difference: $timeDifference seconds", style: const TextStyle(fontSize: 18)),
            
            ButtonSecondary(text: "Generate Key", image: Image.asset('assets/Icons/add.png'), onTap: ()async{generateKey();} ),
            const SizedBox(height: 10,),
            if(syncKey.isNotEmpty)
              ButtonSecondary(text: "Start", image: Image.asset('assets/Icons/start.png'), onTap: (){} ),
            const SizedBox(height: 10,),
            
          ],
        ),
      )),
    );
  }

}