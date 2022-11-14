import 'dart:async';
import 'package:bayfrontend/apis/servicehttpService.dart';
import 'package:bayfrontend/model/Service.dart';
import 'package:bayfrontend/model/User.dart';
import 'package:bayfrontend/model/userService.dart';
import 'package:bayfrontend/services/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bayfrontend/apis/httpService.dart';
import 'package:bayfrontend/model/ServiceType.dart';

class HomeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var total = 0.obs;
  RxInt sumtotal = 0.obs;

  void calculate(List<ServiceTypeModel> selectedItems) {
    sumtotal.value = 0;
    for (var element in selectedItems) {
      sumtotal.value += element.price;
    }
    print("total");
    print(sumtotal.value);
  }

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final passwordController = TextEditingController();
  final amountPaidController = TextEditingController();

  final Rx<List<ServiceTypeModel>> _serviceType = Rx([]);
  HttpService apis = HttpService();
  ServiceHttpService serviceHttpService = ServiceHttpService();
  List<ServiceTypeModel> get serviceType {
    return _serviceType.value;
  }

  void setServiceTypes(value) => _serviceType.value = value;

  @override
  void dispose() {
    total.value = 0;

    super.dispose();
  }

  void cleareverything() {
    nameController.clear();
    passwordController.clear();
    contactController.clear();
    amountPaidController.clear();
    total.value = 0;
  }

  @override
  onInit() async {
    var data = await apis.getServiceTypes("richCode");
    toTalSales();
    super.onInit();
  }

  void toTalSales() async {
    var sales = await serviceHttpService.getTodaySales();
    total.value = 0;
    for (var element in sales) {
      total.value = total.value + element.amount;
    }
  }

  Future<String> addCustomerSales(
      List<ServiceTypeModel> selectedItems, int total) async {
    List<dynamic> serviceTypelist = [];
    for (int index = 0; index < selectedItems.length; index++) {
      serviceTypelist.add({
        'serviceTypeId': selectedItems[index].id.toString(),
      });
    }
    Map<String, dynamic> data = {
      "allserviceTypeIds": serviceTypelist,
      "password": passwordController.text,
      "name": nameController.text,
      "contact": contactController.text,
      "amountTendered": int.parse(amountPaidController.text),
      "amount": total,
      "adminId": await AuthService.getUserId(),
      "balance": int.parse(amountPaidController.text) - total
    };
    String url = await apis.AddUserAndCreateService(data);
    return url;
  }

  Future<List<UserModel>> findUser(String searchKey) async {
    List<UserModel> user = await apis.findUsers(searchKey);
    return user;
  }

  Future<String> createService(
      List<ServiceTypeModel> servicesType, int total, String userId) async {
    String userReport = await apis.createService(
        servicesType,
        userId,
        int.parse(amountPaidController.text),
        total,
        await AuthService.getUserId(),
        int.parse(amountPaidController.text) - total);
    return userReport;
  }
}
