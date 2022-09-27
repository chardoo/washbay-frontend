import 'package:bayfrontend/components/serviceType/DetailsServiceType.dart';
import 'package:bayfrontend/components/serviceType/EditServiceType.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/model/services/sales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SalesComponent extends StatelessWidget {
  SalesModel salesModel = SalesModel(" ", 0, 0, 0, "", "", "");
  SalesComponent({Key? key, required this.salesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Card(
        elevation: 3,
        margin: EdgeInsetsDirectional.only(
            start: screenSize.height * 0.01,
            end: screenSize.height * 0.02,
            top: screenSize.height * 0.02),
        child: Container(
          // height: screenSize.height * 0.08,
          color: Color.fromARGB(255, 248, 249, 250),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(salesModel.clientName,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 26, 21, 21),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text(salesModel.contact,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 26, 21, 21),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text((salesModel.amountTendered).toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 231, 215, 68),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text((salesModel.amount).toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 82, 204, 71),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text(salesModel.balance.toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 231, 45, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.print,
                      color: Color.fromARGB(255, 31, 27, 27),
                    ),
                    onPressed: () async {
                      var pdfPath = salesModel.id + '.pdf';
                      await _launchURLBrowser(
                          "http://localhost:8082/file/pdfs/" + pdfPath);
                    },
                  ),
                ],
              ))
            ],
          ),
        ));
  }

  _launchURLBrowser(String url) async {
    var newurl = Uri.parse(url);
    if (await canLaunchUrl(newurl)) {
      await launchUrl(newurl);
    } else {
      throw 'Could not launch $url';
    }
  }
}
