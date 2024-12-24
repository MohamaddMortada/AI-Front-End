import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    const String apiUrl = "http://127.0.0.1:8000/api/auth/login";

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await storage.write(key: 'jwt_token', value: data['token']);
        //print('token: ${data['token']}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful! Welcome, $email")),
        );
        Get.toNamed('/main');
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${error['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Unable to login. Check your connection.")),
      );
    } finally {
      isLoading.value = false;
    }
  }
}