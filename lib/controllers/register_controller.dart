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
        final String apiUrl = "http://localhost:8000/api/auth/register";
        
  }
}

