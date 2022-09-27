import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    contactController.dispose();

    super.onClose();
  }

  String? contactValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }

    if (value.length < 10) {
      return ' number should must be equal to 10 or more';
    }
    if (value.length < 10) {
      return ' number should must be equal to 10 or more';
    }
    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Username too short';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Password too short';
    }
    return null;
  }

  String? emailValidator(String? value) {
    //email RegExp
    final _emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Username too short';
    }
    return null;
  }

  Future<bool> register() async {
    Map<String, dynamic> registerDetails = {
      "name": usernameController.text,
      "password": passwordController.text,
      "contact": contactController.text,
      "confirm_password": confirmPasswordController.text,
      "email": emailController.text
    };

    return false;
  }
}
