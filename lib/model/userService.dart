import 'package:bayfrontend/model/Service.dart';
import 'package:bayfrontend/model/User.dart';

class UserServiceModel {
  late int amount;
  late int balance;
  late String day;
 late  String id = '';
 late String name = "";
 late String contact = "";

  UserServiceModel(this.amount, this.balance, this.day, this.id, this.name, this.contact);

  //deserialization
  factory UserServiceModel.fromJson(Map<String, dynamic> json) {
    return UserServiceModel(
      int.parse(json["amount"]),
      int.parse(json["balance"]),
      json["createdAt"],
      json["user"]['id'],
      json["user"]['name'],
      json["user"]['contact'],
    );
  }
}
