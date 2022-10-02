import 'package:bayfrontend/apis/httpService.dart';
import 'package:bayfrontend/components/listOfServicesTypes.dart';
import 'package:bayfrontend/contollers/serviceType_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bayfrontend/components/Drawer.dart';
//import '../components/video/videoCard.dart';
//import 'SearchPage.dart';

import 'package:bayfrontend/model/ServiceType.dart';

// ignore: must_be_immutable
class ServiceType extends StatelessWidget {
  // final serviceTypesController = Get.find<ServiceTypesController>();

  final ServiceTypesController serviceTypesController =
      Get.put(ServiceTypesController());
  final serviceTypeModel = ServiceTypeModel("", "", 0);
  Icon customIcon = const Icon(Icons.search);
  ServiceType({Key? key}) : super(key: key);
  bool get wantKeepAlive => false;
  get context => null;
  HttpService api = new HttpService();
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
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 231, 229, 229),
          title: Center(
            child: Text("All Services",
                style: TextStyle(
                    color: Color.fromARGB(255, 26, 21, 21),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          )),
      // body: Container(child: listOfServiceType(context, serviceType))
      body: FutureBuilder(
          future: api.getServiceTypes("resquestData"),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
                  .hasData
              ? Container(
                  child: listOfServiceType(context, snapshot.data as dynamic))

                  :snapshot ==null ?  Center(child: Text("Please add a service Type"),)
              : const Center(
                  // render the loading indicator
                  child: CircularProgressIndicator(),
                )),
    );
  }

  AppBar _getAppBar(context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 50,
            color: Color.fromARGB(255, 248, 247, 247),
          ),
          onPressed: () {
            _addingNewServiceType(context);
          },
        ),
        SizedBox(
          width: 30,
        ),
      ],
      backgroundColor: Colors.black,
      title: Row(
        children: [],
      ),
    );
  }

  Future<void> _addingNewServiceType(
    BuildContext context,
  ) async {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var screenSize = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Add New Service Type'),
              content: Container(
                height: height * 0.4,
                width: width * 0.4,
                child: Form(
                  key: serviceTypesController.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 250, 250, 250),
                            focusColor: Color(0xFF800020),
                            hintText: 'Name of the Service',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 173, 167, 169),
                            )),
                        // onChanged: (value) {
                        //   serviceTypeModel.name = value;
                        // },
                        controller: serviceTypesController.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name of the service';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 250, 250, 250),
                            focusColor: Color(0xFF800020),
                            hintText: 'Price of the Service',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 173, 167, 169),
                            )),
                        // onChanged: (value) {
                        //   serviceTypeModel.price = int.parse(value);
                        // },
                        controller: serviceTypesController.priceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name of the service';
                          }
                          if (int.parse(value) <= 0) {
                            return 'This field must be greater than 0';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Material(
                              elevation: 5,
                              color: Color.fromARGB(255, 12, 9, 10),
                              child: MaterialButton(
                                  child: const Text(
                                    'Create',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  onPressed: () async {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (serviceTypesController
                                        .formKey.currentState!
                                        .validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'adding a service type')));
                                      bool registered =
                                          await serviceTypesController
                                              .createServiceType();
                                      if (!registered) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Registration failed!')));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text('Succesfull!')));
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ServiceType()), // this mymainpage is your page to refresh
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                    }
                                  }),
                            ),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),
                              // textStyle: MaterialStateProperty.all(Colors.white)
                              ),
                                  // color: Colors.red,
                                  // textColor: Colors.white,
                                  child: Text('CANCEL'),
                                  onPressed: () =>
                                      Navigator.pop(context, false))),
                        ],
                      ),
                    ],

                    // actions: <Widget>[
                    //   FlatButton(
                    //     color: Colors.red,
                    //     textColor: Colors.white,
                    //     child: const Text('CANCEL'),
                    //     onPressed: () {},
                    //   ),
                    //   FlatButton(
                    //     color: Colors.green,
                    //     textColor: Colors.white,
                    //     child: const Text('Save'),
                    //     onPressed: () {
                    //       print("hello man how are you doing");
                    //       print(serviceTypeModel.toJson());
                    //     },
                    //   ),
                    // ],
                  ),
                ),
              ));
        });
  }
}
