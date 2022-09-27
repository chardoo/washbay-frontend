import 'package:flutter/material.dart';
import 'package:bayfrontend/components/custom/textfield.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/contollers/serviceType_controller.dart';

class EditServiceType extends StatelessWidget {
  ServiceTypeModel serviceTypeModel = ServiceTypeModel("", "", 0);
  final serviceTypesController = Get.find<ServiceTypesController>();
  EditServiceType({Key? key, required this.serviceTypeModel}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: serviceTypeModel.name);
    TextEditingController priceController =
        TextEditingController(text: serviceTypeModel.price.toString());
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 13, 14, 17),
            elevation: 0.0,
            title: Text('Edit Service Type')),
        body: Center(
          heightFactor: 1,
          child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.20,
                left: screenSize.width / 5,
                right: screenSize.width / 5,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 250, 250, 250),
                          focusColor: Color(0xFF800020),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 173, 167, 169),
                          )),
                      // onChanged: (value) {
                      //   serviceTypeModel.price = int.parse(value);
                      // },
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name of the service';
                        }

                        return null;
                      },
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
                      controller: priceController,
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
                    SizedBox(
                      width: 100,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 20, 12, 12)),
                          onPressed: () async {
                            var users = serviceTypeModel,
                                name = nameController.text,
                                price = priceController.text;
                            if (formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Updating service...')));
                              bool registered = await serviceTypesController
                                  .updateServiceType(users.id, name, price);

                              if (!registered) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Updation failed!')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Update Succesfull!')));
                                Get.offNamed('/allService');
                              }
                            }
                          },
                          child: Text(
                            'Save',
                          )),
                    )
                  ],
                ),
              )),
        ));
  }
}
