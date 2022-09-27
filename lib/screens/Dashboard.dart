import 'dart:convert';

import 'package:bayfrontend/apis/httpService.dart';
import 'package:bayfrontend/apis/servicehttpService.dart';
import 'package:bayfrontend/components/listOfServicesTypes.dart';
import 'package:bayfrontend/model/Service.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/model/User.dart';
import 'package:bayfrontend/model/dashboardData.dart';
import 'package:bayfrontend/model/invoice/customer.dart';
import 'package:bayfrontend/model/invoice/invoice.dart';
import 'package:bayfrontend/model/invoice/supplier.dart';
import 'package:bayfrontend/apis/pdf/apiPdfInvoice.dart';
import 'package:bayfrontend/apis/pdf/pdf_invoice_api.dart';
import 'package:bayfrontend/model/userService.dart';
import 'package:bayfrontend/screens/Sales.dart';
import 'package:bayfrontend/screens/allServiceType.dart';
import 'package:bayfrontend/screens/finalReport.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:bayfrontend/components/inputField.dart';
import 'package:bayfrontend/components/AppBar.dart';
import 'package:bayfrontend/components/Drawer.dart';
import 'package:bayfrontend/contollers/home_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:open_file/open_file.dart';
//import '../components/video/videoCard.dart';
//import 'SearchPage.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DashBoard extends GetView<HomeController> {
  // HomeController homeController = Get.find();
  var homeController = Get.put(HomeController());
  final userModel = UserModel("", "", "");
  final serviceModel = Service("", "", "", 0, 0);
  String userId = '';

  Icon customIcon = const Icon(Icons.search);
  DashBoard({Key? key}) : super(key: key);
  bool get wantKeepAlive => false;
  get context => null;
  HttpService api = HttpService();
  ServiceHttpService apis = new ServiceHttpService();

  get pdfpath => null;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: _getAppBar(context, homeController),
      //   body: mainBody(context, userController.events),
      drawer: sideDrawer(
        context,
      ),
      body: FutureBuilder<DashboardModel>(
        future: apis.dashboard(),
        builder: (context, AsyncSnapshot<DashboardModel> snapshot) {
          if (snapshot.hasData) {
            // return Text(snapshot.data!.customers.toString());
            return SafeArea(
                child: Scaffold(
              backgroundColor: Color.fromRGBO(230, 233, 239, 4),

              body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                child: GridView.count(
                  crossAxisCount: 4,
                  padding: EdgeInsets.all(3.0),
                  children: <Widget>[
                    makeDashboardItem(
                        "Total Amount: ${snapshot.data!.service.toString()}",
                        Icons.monetization_on),
                    makeDashboardItem(
                        "Total Customer: ${snapshot.data!.customers.toString()}",
                        Icons.people),
                    makeDashboardItem(
                        "Service Types:  ${snapshot.data!.serviceType.toString()}",
                        Icons.cleaning_services),
                    makeDashboardItem("Alphabet", Icons.alarm),
                  ],
                ),
              ),

              // body: Column(

              //   children: [
              //   Row(

              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Expanded(
              //           child: Card(
              //         color: Color.fromARGB(255, 218, 217, 214),
              //         elevation: 20,
              //         shadowColor: Colors.black,
              //         child: SizedBox(
              //             width: 250,
              //             height: 300,
              //             child: Padding(
              //                 padding: const EdgeInsets.all(20.0),
              //                 child: Column(
              //                   children: [
              //                     CircleAvatar(
              //                       backgroundColor:
              //                           Color.fromARGB(255, 13, 14, 13),
              //                       radius: 50,
              //                       child: Icon(
              //                         Icons.monetization_on_sharp,
              //                         size: 50,
              //                       ), //CircleAvatar
              //                     ), //CircleAvatar
              //                     const SizedBox(
              //                       height: 10,
              //                     ), //SizedBox
              //                     Row(
              //                       children: [
              //                         Expanded(
              //                             child: Text(
              //                           "Total Amount:  ",
              //                           style: TextStyle(
              //                             fontSize: 30,
              //                             color: Colors.green[900],
              //                             fontWeight: FontWeight.w500,
              //                           ), //Textstyle
              //                         )),
              //                         Expanded(
              //                             child: Text(
              //                           snapshot.data!.service.toString(),
              //                           style: TextStyle(
              //                             fontSize: 30,
              //                             color: Colors.green[900],
              //                             fontWeight: FontWeight.w500,
              //                           ), //Textstyle
              //                         )),
              //                       ],
              //                     )
              //                   ],
              //                 ))),
              //       )),
              //       // SizedBox(
              //       //   width: 15,
              //       // ),
              //       Expanded(
              //           child: Card(
              //         color: Color.fromARGB(255, 218, 217, 214),
              //         elevation: 20,
              //         shadowColor: Colors.black,
              //         child: SizedBox(
              //             width: 250,
              //             height: 300,
              //             child: Padding(
              //                 padding: const EdgeInsets.all(20.0),
              //                 child: Column(
              //                   children: [
              //                     CircleAvatar(
              //                       backgroundColor:
              //                           Color.fromARGB(255, 30, 31, 30),
              //                       radius: 50,
              //                       child: Icon(
              //                         Icons.people,
              //                         size: 50,
              //                       ), //CircleAvatar
              //                     ), //CircleAvatar
              //                     const SizedBox(
              //                       height: 10,
              //                     ), //SizedBox
              //                     Row(
              //                       children: [
              //                         Expanded(
              //                             flex: 1,
              //                             child: Text(
              //                               "Total Customer: ",
              //                               style: TextStyle(
              //                                 fontSize: 30,
              //                                 color: Colors.green[900],
              //                                 fontWeight: FontWeight.w500,
              //                               ), //Textstyle
              //                             )),
              //                         Expanded(
              //                             child: Text(
              //                           snapshot.data!.customers.toString(),
              //                           style: TextStyle(
              //                             fontSize: 30,
              //                             color: Colors.green[900],
              //                             fontWeight: FontWeight.w500,
              //                           ), //Textstyle
              //                         )),
              //                       ],
              //                     )
              //                   ],
              //                 ))),
              //       )),
              //       Expanded(
              //           child: Card(
              //         color: Color.fromARGB(255, 218, 217, 214),
              //         elevation: 20,
              //         shadowColor: Colors.black,
              //         child: SizedBox(
              //             width: 250,
              //             height: 300,
              //             child: Padding(
              //                 padding: const EdgeInsets.all(20.0),
              //                 child: Column(
              //                   children: [
              //                     CircleAvatar(
              //                       backgroundColor:
              //                           Color.fromARGB(255, 22, 22, 22),
              //                       radius: 50,
              //                       child: Icon(
              //                         Icons.local_car_wash_outlined,
              //                         size: 50,
              //                       ),
              //                     ), //CircleAvatar
              //                     const SizedBox(
              //                       height: 10,
              //                     ), //SizedBox
              //                     Row(
              //                       children: [
              //                         Expanded(
              //                             child: Text(
              //                           "Service Types: ",
              //                           style: TextStyle(
              //                             fontSize: 30,
              //                             color: Colors.green[900],
              //                             fontWeight: FontWeight.w500,
              //                           ), //Textstyle
              //                         )),
              //                         Expanded(
              //                             child: Text(
              //                           snapshot.data!.serviceType.toString(),
              //                           style: TextStyle(
              //                             fontSize: 30,
              //                             color: Colors.green[900],
              //                             fontWeight: FontWeight.w500,
              //                           ), //Textstyle
              //                         )),
              //                       ],
              //                     )
              //                   ],
              //                 ))),
              //       )),
              //     ],
              //   )
              // ]),
            ));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  AppBar _getAppBar(context, HomeController homeController) {
    return AppBar(
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () => {Raffle(context)},
          child: Text("Raffle",
              style: TextStyle(
                  color: Color.fromARGB(255, 253, 253, 253), fontSize: 20)),
          style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 176, 177, 177),
              elevation: 5,
              onSurface: Colors.white,
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
        ),
        TextButton(
            style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 176, 177, 177),
                elevation: 5,
                onSurface: Colors.white,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))

                /// Background Color
                ),
            onPressed: (() => {addsalesDialog(context, homeController)}),
            child: Text(
              "Add Sales",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
            )),
        SizedBox(
          width: 30,
        ),
        TextButton(
            style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 176, 177, 177),
                elevation: 5,
                onSurface: Colors.white,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(5))) // Background Color
                ),
            onPressed: () {
              newCustomerDialog(context, homeController);
            },
            child: Text(
              "New Customer",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
            )),
      ],
      backgroundColor: Colors.black,
      title: Row(
        children: [],
      ),
    );
  }

  Future<void> newCustomerDialog(
      BuildContext context, HomeController homeController) async {
    var items = await api.getServiceTypes("ffd");
    serviceModel.amount = items[0].price;
    serviceModel.serviceTypeId = items[0].id;

    final itemlist = items
        .map((serviceType) =>
            MultiSelectItem<ServiceTypeModel>(serviceType, serviceType.name))
        .toList();
    int total = 0;
    List<ServiceTypeModel> selectedItems = [];

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 204, 199, 199),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                    color: Color.fromARGB(255, 204, 199, 199),
                    height: height * 0.7,
                    width: width * 0.5,
                    child: Form(
                      key: homeController.formKey,
                      child: Column(
                        children: [
                          Text(
                            "Add a Customer",
                            style: TextStyle(
                                color: Color.fromARGB(255, 85, 84, 84),
                                fontSize: 30),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 230, 230),
                                focusColor: Color(0xFF800020),
                                hintText: 'Name of the customer',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 173, 167, 169),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the name of the Customer';
                              }
                              return null;
                            },
                            controller: homeController.nameController,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 230, 230),
                                focusColor: Color(0xFF800020),
                                hintText: 'Telphone',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 173, 167, 169),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the name of the Customer';
                              }
                              return null;
                            },
                            controller: homeController.contactController,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 230, 230),
                                focusColor: Color(0xFF800020),
                                hintText: 'password',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 173, 167, 169),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            controller: homeController.passwordController,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          MultiSelectDialogField<ServiceTypeModel>(
                            backgroundColor: Color.fromARGB(255, 233, 230, 230),
                            dialogWidth: 300,
                            items: itemlist,
                            listType: MultiSelectListType.CHIP,
                            onConfirm: (values) {
                              selectedItems = values;
                              controller.total.value = 0;
                              for (int i = 0; i < values.length; i++) {
                                controller.total += values[i].price;
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 230, 230),
                                focusColor: Color(0xFF800020),
                                hintText: 'Enter Customer Amount',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 173, 167, 169),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount ';
                              } else if (int.parse(value) <
                                  controller.total.value) {
                                return "please amount can't be less than the service amount";
                              }
                              return null;
                            },
                            controller: homeController.amountPaidController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Kindly pay this Amount",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 94, 90, 90)),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        controller.total.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      )),
                                ],
                              ))
                        ],
                      ),
                    ));
              },
            ),
            actions: <Widget>[
              FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('CANCEL'),
                  onPressed: () => Navigator.pop(context, false)),
              FlatButton(
                color: Color.fromARGB(255, 16, 24, 41),
                textColor: Colors.white,
                child: Text('Save and Print'),
                onPressed: () async {
                  if (homeController.formKey.currentState!.validate() &&
                      selectedItems.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saving adding...')));
                    String pdfPath = await homeController.addCustomerSales(
                        selectedItems, controller.total.value);
                    ;
                    homeController.cleareverything();
                    await _launchURLBrowser(
                        "http://localhost:8082/file/" + pdfPath);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DashBoard()), // this mymainpage is your page to refresh
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> addsalesDialog(
      BuildContext context, HomeController homeController) async {
    var items = await api.getServiceTypes("ffd");
    serviceModel.amount = items[0].price;
    serviceModel.serviceTypeId = items[0].id;

    final itemlist = items
        .map((serviceType) =>
            MultiSelectItem<ServiceTypeModel>(serviceType, serviceType.name))
        .toList();
    int total = 0;
    List<ServiceTypeModel> selectedItems = [];

    final _multiSelectKey = GlobalKey<FormFieldState>();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 204, 199, 199),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                    color: Color.fromARGB(255, 204, 199, 199),
                    height: height * 0.6,
                    width: width * 0.5,
                    child: Form(
                      key: homeController.formKey,
                      child: Column(
                        children: [
                          Text(
                            "Add a Service",
                            style: TextStyle(
                                color: Color.fromARGB(255, 85, 84, 84),
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FindDropdown<UserModel>(
                            validate: (selectedText) {
                              if (userId == "") {
                                return 'Please select a customer ';
                              }
                              return null;
                            },
                            label: "Select a Customer",
                            onFind: (String filter) =>
                                homeController.findUser(filter),
                            onChanged: (UserModel? data) {
                              userId = data!.id;
                            },
                            dropdownBuilder:
                                (BuildContext context, UserModel? item) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 233, 230, 230),
                                ),
                                child: (item?.name == null)
                                    ? ListTile(
                                        leading: Icon(Icons.people),
                                        title: Text("No Customer selected"))
                                    : ListTile(
                                        title: Text(item!.name),
                                        subtitle: Text(item.contact.toString()),
                                      ),
                              );
                            },
                            dropdownItemBuilder: (BuildContext context,
                                UserModel item, bool isSelected) {
                              return Container(
                                decoration: !isSelected
                                    ? null
                                    : BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                child: ListTile(
                                  selected: isSelected,
                                  title: Text(item.name),
                                  subtitle: Text(item.contact.toString()),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          MultiSelectDialogField<ServiceTypeModel>(
                            dialogWidth: 300,
                            items: itemlist,
                            listType: MultiSelectListType.CHIP,
                            onConfirm: (values) {
                              selectedItems = values;
                              controller.total.value = 0;
                              for (int i = 0; i < values.length; i++) {
                                controller.total += values[i].price;
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 230, 230),
                                focusColor: Color(0xFF800020),
                                hintText: 'Enter paying Amount',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 173, 167, 169),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount ';
                              } else if (int.parse(value) <
                                  controller.total.value) {
                                return "please amount can't be less than the service amount";
                              }
                              return null;
                            },
                            controller: homeController.amountPaidController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Kindly pay this Amount",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 34, 32, 32)),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      )),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                      child: Text(
                                    controller.total.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ))
                                ],
                              ))
                        ],
                      ),
                    ));
              },
            ),
            actions: <Widget>[
              FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('CANCEL'),
                  onPressed: () => Navigator.pop(context, false)),
              FlatButton(
                color: Color.fromARGB(255, 16, 24, 41),
                textColor: Colors.white,
                child: Text('Save and Print'),
                onPressed: () async {
                  if (homeController.formKey.currentState!.validate() &&
                      userId != '' &&
                      selectedItems.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 8, 8, 8),
                        content: Text('adding to Sales')));
                    String pdfPath = await homeController.createService(
                        selectedItems, controller.total.value, userId);

                    homeController.cleareverything();

                    print(pdfPath);
                    await _launchURLBrowser(
                        "http://localhost:8082/file/" + pdfPath);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DashBoard()), // this mymainpage is your page to refresh
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ],
          );
        });
  }

  _launchURL(link) async {
    print("opening the file please wait");
    await OpenFile.open(link);
  }

  _launchURLBrowser(String url) async {
    var newurl = Uri.parse(url);
    if (await canLaunchUrl(newurl)) {
      await launchUrl(newurl);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> Raffle(BuildContext context) async {
    var winner = await api.findWinner("ffd");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 204, 199, 199),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                    color: Color.fromARGB(255, 204, 199, 199),
                    height: height * 0.6,
                    width: width * 0.5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${winner.name.capitalize}   Won',
                                style: TextStyle(fontSize: 50))
                          ],
                        ),
                        Text(
                          'call this number:   ${winner.contact}',
                          style: TextStyle(
                              color: Color.fromARGB(255, 216, 46, 34),
                              fontSize: 35),
                        )
                      ],
                    ));
              },
            ),
          );
        });
  }

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                Center(
                  child: Text(title,
                      style: TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}
