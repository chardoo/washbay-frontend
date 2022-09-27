import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bayfrontend/apis/httpService.dart';
import 'package:bayfrontend/model/ServiceType.dart';

class ServiceTypesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final editNameController = TextEditingController();
  final editPriceController = TextEditingController();

  final Rx<List<ServiceTypeModel>> _serviceType =
      Rx([ServiceTypeModel('1', 'dssdss', 0)]);
  HttpService apis = HttpService();

  List<ServiceTypeModel> get serviceType {
    return _serviceType.value;
  }

  void setServiceTypes(value) => _serviceType.value = value;

  // @override
  // void onClose() {
  //   nameController.dispose();
  //   priceController.dispose();
  //   editNameController.dispose();
  //   editPriceController.dispose();
  //   super.onClose();
  // }

  @override
  onInit() async {
    var data = await apis.getServiceTypes("richCode");

    setServiceTypes(data);
    super.onInit();
  }

  Future<bool> createServiceType() async {
    Map<String, dynamic> data = {
      "name": nameController.text,
      "price": priceController.text,
    };
    String response = await apis.createServiceType(data);
    if (response == 'error') {
      return false;
    }
    var getAllServiceType = await apis.getServiceTypes("richCode");
    setServiceTypes(getAllServiceType);
    return true;
  }

  Future<bool> updateServiceType(String id, String name, String price) async {
    Map<String, dynamic> data = {
      "serviceId": id,
      "name": name,
      "price": price,
    };
    String response = (await apis.updateServiceType(data));
    if (response == 'error') {
      return false;
    }
    var getAllServiceType = await apis.getServiceTypes("richCode");
    setServiceTypes(getAllServiceType);
    return true;
  }

  // validate inputs

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (int.parse(value) > 0) {
      return 'This field must be greater than 0';
    }
    return null;
  }
}
