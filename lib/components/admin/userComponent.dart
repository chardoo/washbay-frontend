import 'package:bayfrontend/components/serviceType/DetailsServiceType.dart';
import 'package:bayfrontend/components/serviceType/EditServiceType.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/model/User.dart';
import 'package:bayfrontend/model/services/sales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserComponent extends StatelessWidget {
  UserModel userModel = UserModel("", "", "");
  UserComponent({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Card(
        elevation: 3,
        margin: EdgeInsetsDirectional.only(
            start: screenSize.height * 0.08,
            end: screenSize.height * 0.08,
            top: screenSize.height * 0.02),
        child: Container(
          height: screenSize.height * 0.06,
          color: Color.fromARGB(255, 248, 249, 250),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(userModel.name,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 26, 21, 21),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(userModel.contact,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 26, 21, 21),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
