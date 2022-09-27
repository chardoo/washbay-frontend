import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/contollers/login_controller.dart';
import '/contollers/user_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final loginController = Get.find<LoginController>();
  final userController = Get.find<UserController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: const Center(
            child: Text(
          'Stanest Bay',
          style: TextStyle(color: Colors.red, fontSize: 45),
        )),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () async {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    if (userController.authenticated) {
      Get.offNamed('/dashboard');
    } else {
      Get.offNamed('/login');
    }
  }
}
