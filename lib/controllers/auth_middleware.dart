import 'package:flutter/material.dart';
import 'package:front_end/controllers/auth_controller.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = AuthController();

    authController.isAuthenticated().then((isAuth) {
      if (!isAuth) {
        return const RouteSettings(name: '/login');
      }
    });

    return null;
  }
}
