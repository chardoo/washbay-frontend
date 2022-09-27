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
class Sales extends StatelessWidget {
  // final serviceTypesController = Get.find<ServiceTypesController>();
  TextEditingController dateInput = TextEditingController();
  TextEditingController endDate = TextEditingController();
  final ServiceTypesController serviceTypesController =
      Get.put(ServiceTypesController());
  final serviceTypeModel = ServiceTypeModel("", "", 0);
  Icon customIcon = const Icon(Icons.search);
  Sales({Key? key}) : super(key: key);
  bool get wantKeepAlive => false;
  get context => null;
  HttpService api = new HttpService();

  ServiceHttpService apis = new ServiceHttpService();

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
      backgroundColor: Color.fromARGB(255, 219, 218, 218),
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 219, 217, 216),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    subtitle: TextField(
                      controller: dateInput,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Start Date" //label text of field
                          ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          dateInput.text =
                              formattedDate; //set output date to TextField value
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ListTile(
                    subtitle: TextField(
                      controller: endDate,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "End Date" //label text of field
                          ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          endDate.text =
                              formattedDate; //set output date to TextField value
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    subtitle: TextButton(
                      style: ButtonStyle(),
                      onPressed: () async {
                        if (endDate.text.isNotEmpty &&
                            dateInput.text.isNotEmpty) {
                          var results = await apis.SalesRange(
                              endDate.text, dateInput.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RangeOfSales(salesModel: results)),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            'sorry choose a date!',
                            style: TextStyle(color: Colors.red),
                          )));
                        }
                      },
                      child: Text('Search'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      // body: Container(child: listOfServiceType(context, serviceType))
      body: FutureBuilder(
          future: apis.getTodaySales(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
                  .hasData
              ? Container(child: ListOfSales(context, snapshot.data as dynamic))
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
          Text("Todays Sales",
              style: TextStyle(
                  color: Color.fromARGB(255, 252, 252, 252),
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }



  
}
