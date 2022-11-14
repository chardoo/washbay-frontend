import 'package:bayfrontend/model/Service.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/model/User.dart';
import 'package:bayfrontend/model/userService.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:bayfrontend/model/Event.dart';
import '../model/LoginResponse.dart';
import '../model/Photo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bayfrontend/constants/index.dart';

class HttpService {
  Constants contance = Constants();

  static const BASE_URL = "http://localHost:8082";

  static const loginApi = BASE_URL + '/admin/login';
  static const AdminloginApi = BASE_URL + '/admin/loginAdmin';

  static const serviceTypeApi = BASE_URL + '/admin/ServicesType/getAll';
  static const createserviceTypeApi = BASE_URL + '/admin/createserviceType';
  static const updateServiceTypeApi = BASE_URL + '/admin/updateServiceType';
  static const findUserEnpoint = BASE_URL + '/admin/getAllUsers';
  static const raffleWinnerEnpoint = BASE_URL + '/admin/getwinner';
  static const createUserAndcreateServiceEnpoint =
      '$BASE_URL/admin/createUserAndCreateService';
  static const createServiceEnpoint = '$BASE_URL/admin/createService';

  static const TodaySaleEnpoint = '$BASE_URL/admin/todaySales';

  Future<dynamic> login(Map<String, dynamic> resquestData) async {
    var res = await post(Uri.parse(loginApi), body: resquestData);
    var body = jsonDecode(res.body);

    print(res.statusCode);
    switch (res.statusCode) {
      case 200:
        LoginResponseObject user = LoginResponseObject.fromJson(body);
        return user;
      default:
        return false;
    }
  }

  Future<dynamic> adminlogin(Map<String, dynamic> resquestData) async {
    var res = await post(Uri.parse(AdminloginApi), body: resquestData);
    var body = jsonDecode(res.body);
    switch (res.statusCode) {
      case 200:
        LoginResponseObject user = LoginResponseObject.fromJson(body);
        return user;
      default:
        return false;
    }
  }

  Future<List<ServiceTypeModel>> getServiceTypes(String resquestData) async {
    var res = await get(Uri.parse(serviceTypeApi));
    List<dynamic> body = jsonDecode(res.body);

    List<ServiceTypeModel> serviceTypes = body
        .map(
          (dynamic item) => ServiceTypeModel.fromMap(item),
        )
        .toList();
    return serviceTypes;
  }

  Future<String> createServiceType(payload) async {
    var res = await post(Uri.parse(createserviceTypeApi), body: payload);
    if (res.statusCode != 201) {
      return "error";
    }
    return "success";
  }

  Future<String> updateServiceType(payload) async {
    var res = await post(Uri.parse(updateServiceTypeApi), body: payload);
    if (res.statusCode != 200) {
      return "error";
    }
    return "success";
  }

  // create a service
  // ignore: non_constant_identifier_names
  Future<String> AddUserAndCreateService(resquestData) async {
    var res = await post(Uri.parse(createUserAndcreateServiceEnpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(resquestData));
    dynamic body = jsonDecode(res.body);

    return body['url'];
  }

  //  anything related to userData
  Future<List<UserModel>> findUsers(String request) async {
    var res =
        await post(Uri.parse(findUserEnpoint), body: {"queryString": request});

    List<dynamic> body = jsonDecode(res.body);
    List<UserModel> users = body
        .map(
          (dynamic item) => UserModel.fromJson1(item),
        )
        .toList();
    return users;
  }

  Future<String> createService(
      List<ServiceTypeModel> servicesType,
      String userId,
      int amountTendered,
      int amount,
      String adminId,
      int balance) async {
    List<dynamic> serviceTypelist = [];
    for (int index = 0; index < servicesType.length; index++) {
      serviceTypelist.add({
        'serviceTypeId': servicesType[index].id.toString(),
      });
    }

    var res = await post(Uri.parse(createServiceEnpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "allserviceTypeIds": serviceTypelist,
          "amountTendered": amountTendered,
          "userId": userId,
          "amount": amount,
          "adminId": adminId,
          "balance": balance
        }));
    dynamic body = jsonDecode(res.body);

    return body['url'];
  }

  Future<UserModel> findWinner(String request) async {
    var res = await get(Uri.parse(raffleWinnerEnpoint));
    dynamic body = jsonDecode(res.body);
    UserModel users = UserModel.fromJson2(body);

    return users;
  }
}
