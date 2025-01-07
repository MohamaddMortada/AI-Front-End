import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
Future<void> saveUserData(Map<String, dynamic> userData) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('userId', userData['id'].toString());
  await prefs.setString('userName', userData['name']);
  await prefs.setString('userEmail', userData['email']); 
}

  Future<void> registerUser(
    BuildContext context,
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
        const String apiUrl = "http://10.0.2.2:8000/api/auth/register";
        if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match!")),
        );
        return;
    } 
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await saveUserData(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful! Welcome, ${data['name']}")),
        );
        Get.toNamed('/main');
        

      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${error['message']}")),
        );
      }
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Unable to register")),
      );
    } finally {
      isLoading.value = false;
    }
  }
}

