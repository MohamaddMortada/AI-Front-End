import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final storage = FlutterSecureStorage();

  Future<http.Response> request(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final String? token = await storage.read(key: 'jwt_token');

    if (token == null) {
      throw Exception("Unauthorized: No token found");
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(Uri.parse(endpoint), headers: headers);
      case 'POST':
        return await http.post(Uri.parse(endpoint),
            headers: headers, body: jsonEncode(body));
      case 'PUT':
        return await http.put(Uri.parse(endpoint),
            headers: headers, body: jsonEncode(body));
      case 'DELETE':
        return await http.delete(Uri.parse(endpoint), headers: headers);
      default:
        throw Exception("Unsupported HTTP method");
    }
  }
}
