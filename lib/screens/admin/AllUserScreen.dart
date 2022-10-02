import 'package:bayfrontend/apis/customershttpService.dart';
import 'package:bayfrontend/apis/httpService.dart';
import 'package:bayfrontend/apis/servicehttpService.dart';
import 'package:bayfrontend/components/listOfServicesTypes.dart';
import 'package:bayfrontend/contollers/serviceType_controller.dart';
import 'package:bayfrontend/screens/admin/RangeOfSales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bayfrontend/components/Drawer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//import '../components/video/videoCard.dart';
//import 'SearchPage.dart';

import 'package:bayfrontend/model/ServiceType.dart';

// ignore: must_be_immutable
class AllUserScreen extends StatelessWidget {
  // final serviceTypesController = Get.find<ServiceTypesController>();
  TextEditingController dateInput = TextEditingController();
  TextEditingController endDate = TextEditingController();
  final ServiceTypesController serviceTypesController =
      Get.put(ServiceTypesController());
  final serviceTypeModel = ServiceTypeModel("", "", 0);
  Icon customIcon = const Icon(Icons.search);
  AllUserScreen({Key? key}) : super(key: key);
  bool get wantKeepAlive => false;
  get context => null;
  CustomerHttpService userApi = new CustomerHttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _getAppBar(context),
      body: mainBody(context, serviceTypesController.serviceType),
      drawer: sideDrawer(context),
    );
  }

  Widget mainBody(context, List<ServiceTypeModel> serviceType) {
    dateInput.text = '';
    return Scaffold(
      // body: Container(child: listOfServiceType(context, serviceType))
      body: FutureBuilder(
          future: userApi.getAllUsers(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
                  .hasData
              ? Container(child: ListOfUser(context, snapshot.data as dynamic))
              :snapshot ==null ? Center(child: Text("please add Users"),)
              : const Center(
                  // render the loading indicator
                  child: CircularProgressIndicator(),
                )),
    );
  }

  AppBar _getAppBar(context) {
    return AppBar(
      actions: [
        SizedBox(
          width: 30,
        ),
      ],
      backgroundColor: Colors.black,
      title: Row(
        children: [
          Text("allusers",
              style: TextStyle(
                  color: Color.fromARGB(255, 252, 252, 252),
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
