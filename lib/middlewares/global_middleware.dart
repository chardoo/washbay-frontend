import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../contollers/user_controller.dart';

class GlobalMiddleware extends GetMiddleware {
  final userController = Get.find<UserController>();

  @override
  RouteSettings? redirect(String? route) {
    if (!userController.authenticated &&
        userController.role != 'agent' &&
        route != '/login') {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}

class AdminMiddleware extends GetMiddleware {
  final userController = Get.find<UserController>();

  @override
  RouteSettings? redirect(String? route) {
    print("###################");
    print(userController.authenticated);
    print(userController.role);

    if (!userController.authenticated &&
        userController.role != 'admin' &&
        route != '/admin/login') {
      return const RouteSettings(name: '/admin/login');
    }

    return null;
  }
}
