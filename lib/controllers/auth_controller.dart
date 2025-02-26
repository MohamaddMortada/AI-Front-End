import 'dart:convert';
import 'package:front_end/controllers/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthController {
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

  Future<void> logoutUser(BuildContext context) async {
    await storage.delete(key: 'jwt_token');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out successfully!")),
    );

    Get.offAllNamed('/login');
  }

  Future<bool> isAuthenticated() async {
    final token = await storage.read(key: 'jwt_token');
    return token != null;
  }

  void checkAuthStatus() async {
    try {
      final String? token = await storage.read(key: 'jwt_token'); 

      if (token == null) {

        Get.offAllNamed('/login');
        return;
      }

      final response = await ApiClient().request(
        'POST', 
        'http://127.0.0.1:8000/api/auth/me',
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body); 
        Get.offAllNamed('/main', arguments: userData);
      } else {

        await storage.delete(key: 'jwt_token');
        Get.offAllNamed('/login');
      }
    }catch (e) {
      
      await storage.delete(key: 'jwt_token');
      Get.offAllNamed('/login');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

}