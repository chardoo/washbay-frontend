import 'dart:convert';
import 'dart:io';
import 'package:bayfrontend/apis/httpService.dart';
import 'package:bayfrontend/apis/servicehttpService.dart';
import 'package:bayfrontend/components/listOfServicesTypes.dart';
import 'package:bayfrontend/contollers/serviceType_controller.dart';
import 'package:bayfrontend/model/Service.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/model/User.dart';
import 'package:bayfrontend/model/invoice/customer.dart';
import 'package:bayfrontend/model/invoice/invoice.dart';
import 'package:bayfrontend/model/invoice/supplier.dart';
import 'package:bayfrontend/apis/pdf/apiPdfInvoice.dart';
import 'package:bayfrontend/apis/pdf/pdf_invoice_api.dart';
import 'package:bayfrontend/model/services/sales.dart';
import 'package:bayfrontend/model/userService.dart';
import 'package:bayfrontend/screens/allServiceType.dart';

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bayfrontend/components/inputField.dart';
import 'package:bayfrontend/components/AppBar.dart';
import 'package:bayfrontend/components/Drawer.dart';
import 'package:bayfrontend/contollers/home_controller.dart';
import 'package:http/http.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_file/open_file.dart';
//import '../components/video/videoCard.dart';
//import 'SearchPage.dart';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AgentDashBoard extends GetView<HomeController> {
  // HomeController homeController = Get.find();
  // var homeController = Get.put(HomeController());
  final pdf = pw.Document();
  final userModel = UserModel("", "", "");
  final serviceModel = Service("", "", "", 0, 0);
  String userId = '';
  final ServiceTypesController serviceTypesController =
      Get.put(ServiceTypesController());

  final HomeController homeController = Get.put(HomeController());
  final serviceTypeModel = ServiceTypeModel("", "", 0);

  bool get wantKeepAlive => false;
  get context => null;
  HttpService api = new HttpService();

  ServiceHttpService apis = new ServiceHttpService();

  Icon customIcon = const Icon(Icons.search);
  AgentDashBoard({Key? key}) : super(key: key);
  Future savePdf() async {
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // await Hive.initFlutter();
    String documentPath = "C:/Users/RichardAppiah/Downloads";
    print('file is about to be write');
    File file = File("$documentPath/example.pdf");
    print('hjhbh jjjjnj');
    file.writeAsBytesSync(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _getAppBar(context, homeController),
      //   body: mainBody(context, userController.events),
      drawer: SalesDrawer(
        context,
      ),
      body: mainBody(context, serviceTypesController.serviceType),
    );
  }

  Widget mainBody(context, List<ServiceTypeModel> serviceType) {
    TextEditingController dateInput = TextEditingController();
    dateInput.text = '';
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 199, 199),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 204, 199, 199),
        // title: Column(
        //   children: [
        //     // Row(
        //     //   children: [
        //     //     FutureBuilder(
        //     //         future: apis.getTodaySales(),
        //     //         builder: (BuildContext ctx,
        //     //             AsyncSnapshot<List<SalesModel>> snapshot) {
        //     //           return Text(
        //     //             "Total",
        //     //             style: TextStyle(color: Colors.black),
        //     //           );
        //     //         }),
        //     //   ],
        //     // )
        //   ],
        // ),
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
// Background Color
                ),
            onPressed: (() => {addsalesDialog(context, homeController)}),
            child: Text(
              "Add Sales",
              style: TextStyle(
                  color: Color.fromARGB(255, 253, 253, 253), fontSize: 20),
            )),
        SizedBox(
          width: 20,
        ),
        TextButton(
            style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 176, 177, 177),
                elevation: 5,
                onSurface: Colors.white,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))
                // Background Color
                ),
            onPressed: () {
              newCustomerDialog(context, homeController);
            },
            child: Text(
              "New Customer",
              style: TextStyle(
                  color: Color.fromARGB(255, 253, 253, 253), fontSize: 20),
            )),
      ],
      backgroundColor: Colors.black,
      title: Obx(() => Row(
            children: [
              Text("Todays Sales  ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 252, 252, 252),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Text(" Total: "),
                  Text(homeController.total.toString())
                ],
              ),
            ],
          )),
    );
  }

  Future<void> newCustomerDialog(
      BuildContext context, HomeController homeController) async {
    var items = await api.getServiceTypes("ffd");
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
                    height: height * 0.6,
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
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red, // foreground
                  ),
                  child: Text('CANCEL'),
                  onPressed: () => Navigator.pop(context, false)),
              TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.white),
                    backgroundColor: Color.fromARGB(255, 12, 6, 5), // foreground
                  ),
                child: Text('Save and Print'),
                onPressed: () async {
                  if (homeController.formKey.currentState!.validate() &&
                      selectedItems.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 8, 8, 8),
                        content: Text(
                          'adding sales',
                          style: TextStyle(color: Colors.white),
                        )));
                    String pdfPath = await homeController.addCustomerSales(
                        selectedItems, controller.total.value);
                    homeController.cleareverything();
                    await _launchURLBrowser(
                        "http://localhost:8082/file/" + pdfPath);
                    homeController.toTalSales();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AgentDashBoard()), // this mymainpage is your page to refresh
                      (Route<dynamic> route) => false,
                    );
                  }
                  // print("user json");
                  // print(serviceModel.serviceTypeId);
                  // print(userModel.name);
                },
              ),
            ],
          );
        });
  }

  Future<void> addsalesDialog(
      BuildContext context, HomeController homeController) async {
    // String value1 = items[0];
    var items = await api.getServiceTypes("ffd");
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
                                        title: Text("Please select a Customer"))
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
            TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red, // foreground
                  ),
                  child: Text('CANCEL'),
                  onPressed: () => Navigator.pop(context, false)),
             TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.white),
                    backgroundColor: Color.fromARGB(255, 12, 6, 5), // foreground
                  ),
                child: Text('Save and Print'),
                onPressed: () async {
                  if (homeController.formKey.currentState!.validate() &&
                      userId != '' &&
                      selectedItems.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 8, 8, 8),
                        content: Text(
                          'adding to Sales',
                          style: TextStyle(color: Colors.white),
                        )));
                    String pdfPath = await homeController.createService(
                        selectedItems, controller.total.value, userId);

                    homeController.cleareverything();
                    homeController.toTalSales();
                    await _launchURLBrowser(
                        "http://localhost:8082/file/" + pdfPath);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AgentDashBoard()), // this mymainpage is your page to refresh
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ],
          );
        });
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
                    height: height * 0.3,
                    width: width * 0.3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${winner.name.capitalize}   Won!!!',
                                style: TextStyle(fontSize: 50))
                          ],
                        ),
                        Text(
                          'call this number:   ${winner.contact}',
                          style: TextStyle(
                              color: Color.fromARGB(255, 216, 46, 34),
                              fontSize: 25),
                        )
                      ],
                    ));
              },
            ),
          );
        });
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
