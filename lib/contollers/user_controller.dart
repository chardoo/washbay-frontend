import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bayfrontend/apis/httpService.dart';
import 'package:bayfrontend/model/Event.dart';
import 'package:bayfrontend/model/Photo.dart';
import '../services/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  TextEditingController Searchcontroller = new TextEditingController();
  final _id = (-1).obs;
  final _username = "".obs;
  final _email = "".obs;
  var _authenticated = false;
  var _role = " ";
  bool get authenticated => _authenticated;
  String get role => _role;
  HttpService apis = new HttpService();

  get username => _username.value;
  set username(value) => _username.value = value;

  set email(value) => _email.value = value;
  get id => _id.value;
  set id(value) => _id.value = value;
  set authenticated(value) {
    _authenticated = value;
    //Get user data once authentication is set to true.
    if (value) {}
  }

  set role(value) {
    _role = value;
    //Get user data once authentication is set to true.
    if (value) {}
  }

  String get email => _email.value;

  @override
  onInit() async {
    await AuthService.getToken().then((token) {
      if (token.isNotEmpty) {
        authenticated = true;
        // appSingleton.connection.headers = {"Authorization": "Bearer $token"};
      }
    });
    await AuthService.getRole().then((role1) {
      if (role1.isNotEmpty) {
        role = role1;
      }
    });

    super.onInit();
  }

  Future<void> logout() async {
    await AuthService.removeToken();
    authenticated = false;
  }
}
