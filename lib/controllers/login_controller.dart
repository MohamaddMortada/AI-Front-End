import 'package:flutter/material.dart';

class LoginController {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    const String apiUrl = "http://localhost:8000/api/auth/login";
  }
}