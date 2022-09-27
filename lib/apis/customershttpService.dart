import 'package:bayfrontend/model/Service.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/model/User.dart';
import 'package:bayfrontend/model/dashboardData.dart';
import 'package:bayfrontend/model/userService.dart';
import 'package:bayfrontend/model/services/sales.dart';
import 'package:bayfrontend/screens/Sales.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:bayfrontend/model/Event.dart';
import '../model/LoginResponse.dart';
import '../model/Photo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerHttpService {
  static const BASE_URL = "http://localHost:8082";

  static const getCustomersEnpoint = '$BASE_URL/admin/getCustomer';

  Future<List<UserModel>> getAllUsers() async {
    var res = await get(Uri.parse(getCustomersEnpoint));
    List<dynamic> body = jsonDecode(res.body);

    List<UserModel> users = body
        .map(
          (dynamic item) => UserModel.fromJson1(item),
        )
        .toList();
    return users;
  }
}
