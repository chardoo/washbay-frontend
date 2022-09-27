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

class ServiceHttpService {
  static const BASE_URL = "http://localHost:8082";
  static const TodaySaleEnpoint = '$BASE_URL/admin/todaySales';
  static const RangeSaleEnpoint = '$BASE_URL/admin/rangeSales';
  static const DashboardEndpoint = '$BASE_URL/admin/getDashbaord';

  Future<List<SalesModel>> getTodaySales() async {
    var res = await get(Uri.parse(TodaySaleEnpoint));
    List<dynamic> body = jsonDecode(res.body);
    List<SalesModel> sales = body
        .map(
          (dynamic item) => SalesModel.fromJson(item),
        )
        .toList();
    return sales;
  }

  Future<List<SalesModel>> SalesRange(String dateTo, String dateFrom) async {
    var res = await post(Uri.parse(RangeSaleEnpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "dateFrom": dateFrom,
          "dateTo": dateTo,
        }));

    List<dynamic> body = jsonDecode(res.body);
    List<SalesModel> sales = body
        .map(
          (dynamic item) => SalesModel.fromJson(item),
        )
        .toList();
    return sales;
  }

  Future<DashboardModel> dashboard() async {
    var res = await get(Uri.parse(DashboardEndpoint));

    var body = jsonDecode(res.body);
    DashboardModel data = DashboardModel.fromJson(body);

    return data;
  }
}
