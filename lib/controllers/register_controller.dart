import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> registerUser(
    BuildContext context,
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
        const String apiUrl = "http://localhost:8000/api/auth/register";
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful! Welcome, ${data['user']['name']}")),
        );
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

