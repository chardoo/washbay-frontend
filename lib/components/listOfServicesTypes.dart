import 'dart:js';

import 'package:bayfrontend/components/Sales/salesComponent.dart';
import 'package:bayfrontend/components/admin/userComponent.dart';
import 'package:bayfrontend/model/User.dart';
import 'package:bayfrontend/model/services/sales.dart';
import 'package:flutter/material.dart';
import '../components/serviceTypeComponent.dart';
import '../model/ServiceType.dart';

ListView listOfServiceType(
    BuildContext context, List<ServiceTypeModel> serviceType) {
  return ListView.builder(
      itemCount: serviceType.length,
      itemBuilder: (context, index) {
        return ServiceTypeComponent(serviceTypeModel: serviceType[index]);
      });
}

Row selectRow(ServiceTypeModel item) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text(item.name), Text(item.price.toString())],
  );
}

ListView ListOfSales(BuildContext, List<SalesModel> sales) {
  return ListView.builder(
      itemCount: sales.length,
      itemBuilder: (context, index) {
        return SalesComponent(salesModel: sales[index]);
      });
}

ListView ListOfUser(BuildContext, List<UserModel> user) {
  return ListView.builder(
      itemCount: user.length,
      itemBuilder: (context, index) {
        return UserComponent(userModel: user[index]);
      });
}
