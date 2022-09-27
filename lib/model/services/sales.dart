import 'package:bayfrontend/model/Service.dart';
import 'package:bayfrontend/model/User.dart';

class SalesModel {
  late String id = '';
  late int amountTendered;
  late int amount;
  late int balance;
  late String clientName = "";
  late String contact = "";

  late String adminUser = "";

  SalesModel(this.id, this.amountTendered, this.amount, this.balance, this.clientName, this.contact,
       this.adminUser);

  //deserialization
  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      json['id'],
      int.parse(json["amountTendered"]),
      int.parse(json["amount"]),
      int.parse(json["balance"]),
      json["user"]['name'],
      json["user"]['contact'],
      json["admin"]['name'],
    );
  }
}
