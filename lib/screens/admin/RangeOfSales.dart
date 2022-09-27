import 'package:bayfrontend/components/Drawer.dart';
import 'package:bayfrontend/components/Sales/salesComponent.dart';
import 'package:bayfrontend/components/listOfServicesTypes.dart';
import 'package:bayfrontend/model/services/sales.dart';
import 'package:flutter/material.dart';
import 'package:bayfrontend/components/custom/textfield.dart';
import 'package:http/http.dart' as http;
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/components/serviceType/EditServiceType.dart';

// ignore: must_be_immutable
class RangeOfSales extends StatelessWidget {
  List<SalesModel> salesModel;
  // SalesModel salesModel = SalesModel("", 0, 0, " ", "", " ", "");

  RangeOfSales({Key? key, required this.salesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    int total = 0;

    for (int i = 0; i < salesModel.length; i++) {
      total += salesModel[i].amount;
    }

    return MaterialApp(
        home: Scaffold(
            drawer: sideDrawer(context),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(251, 13, 13, 14),
              elevation: 0.0,
              title: Row(
                children: [
                  Text('All Sales'),
                  SizedBox(
                    width: 140,
                  ),
                  Text("Total:   "),
                  Text(total.toString())
                ],
              ),
            ),
            body: ListView.builder(
                itemCount: salesModel.length,
                itemBuilder: (context, index) {
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
                            Text(salesModel[index].clientName,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 26, 21, 21),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(salesModel[index].contact,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 26, 21, 21),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text((salesModel[index].amount).toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 26, 21, 21),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.print,
                                    color: Color.fromARGB(255, 31, 27, 27),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ));
                  //return SalesComponent(salesModel: salesModel[index]);
                })));
  }
}
