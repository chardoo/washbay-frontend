import 'package:bayfrontend/components/serviceType/DetailsServiceType.dart';
import 'package:bayfrontend/components/serviceType/EditServiceType.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ServiceTypeComponent extends StatelessWidget {
  ServiceTypeModel serviceTypeModel = ServiceTypeModel(" ", " ", 0);
  ServiceTypeComponent({Key? key, required this.serviceTypeModel})
      : super(key: key);

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
          height: screenSize.height * 0.08,
          color: Color.fromARGB(255, 248, 249, 250),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(serviceTypeModel.name,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 26, 21, 21),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 10,
              ),
              Text(" Ghc: " + serviceTypeModel.price.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 20, 18, 18),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 31, 27, 27),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditServiceType(
                                    serviceTypeModel: serviceTypeModel,
                                  )));
                    },
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.delete,
                  //     color: Color.fromARGB(255, 235, 87, 87),
                  //   ),
                  //   onPressed: () {
                  //     print("$serviceTypeModel clicked man");
                  //   },
                  // ),
                ],
              )
            ],
          ),
        ));
  }
}
