// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:bayfrontend/contollers/login_controller.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  // static const routeName = '/login-screen';

  List<MaterialColor> colorizeColors = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
  ];

  static const colorizeTextStyle =
      TextStyle(fontSize: 25.0, fontFamily: 'SF', color: Colors.redAccent);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800020),
      body: loginBody(context, controller),
    );
  }

  Widget loginBody(context, LoginController controller) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 14, 15),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              // height: MediaQuery.of(context).size.height - 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/2015_K%C5%82odzko%2C_ul._Dusznicka%2C_myjnia_samochodowa_02.jpg/1200px-2015_K%C5%82odzko%2C_ul._Dusznicka%2C_myjnia_samochodowa_02.jpg"),
                        backgroundColor: Color.fromARGB(255, 82, 16, 14),
                        minRadius: 100,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
                  ),
                  Container(
                      width: screenSize.height * 0.7,
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 14, 12, 12),
                          Color.fromARGB(255, 15, 15, 15),
                        ]),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      width: 75,
                                      height: 2,
                                      color: Color.fromARGB(255, 88, 27, 27)),
                                  const Text(
                                    "Login In",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 245, 244, 244),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      width: 75,
                                      height: 2,
                                      color: Color.fromARGB(255, 90, 28, 28)),
                                  const SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                          // enabledBorder: OutlineInputBorder(
                                          //     borderRadius:
                                          //         BorderRadius.all(
                                          //             Radius.circular(20)),
                                          //     borderSide: BorderSide(
                                          //         color: Color(0xFF8A3324),
                                          //         width: 2)),
                                          // focusedBorder: OutlineInputBorder(
                                          //     borderRadius:
                                          //         BorderRadius.all(
                                          //             Radius.circular(20)),
                                          //     borderSide: BorderSide(
                                          //         color: Color(0xFF8A3324),
                                          //         width: 2)),
                                          filled: true,
                                          fillColor: Color.fromARGB(
                                              255, 250, 250, 250),
                                          focusColor: Color(0xFF800020),
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 173, 167, 169),
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter email';
                                        }
                                        return null;
                                      },
                                      controller: controller.emailController,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Obx(() => TextFormField(
                                          obscureText:
                                              controller.ispasswordHidden.value,
                                          decoration: InputDecoration(
                                              errorText:
                                                  controller.isError.value ==
                                                          true
                                                      ? "Invalid Credentials"
                                                      : '',
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.visibility),
                                                onPressed: () {
                                                  controller.ispasswordHidden
                                                          .value =
                                                      !(controller
                                                          .ispasswordHidden
                                                          .value);
                                                },
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF8A3324),
                                                      width: 2)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF8A3324),
                                                      width: 2)),
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 255, 254, 253),
                                              focusColor: Color(0xFF800020),
                                              hintText: 'Password',
                                              hintStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 173, 167, 169),
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter  password';
                                            }
                                            return null;
                                          },
                                          controller:
                                              controller.passwordController,
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: const Color(0xFF800020),
                                        child: MaterialButton(
                                            minWidth: 23,
                                            child: const Text(
                                              'LOG IN',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            onPressed: () async {
                                              if (controller
                                                  .formKey.currentState!
                                                  .validate()) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Signing in...')));
                                                bool loggedIn =
                                                    await controller.login();
                                                if (loggedIn == false) {
                                                  controller.isError.value =
                                                      true;
                                                }
                                                if (loggedIn == true) {
                                                  Get.offNamed('/SalesPage');
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Failed to login!')));
                                                }
                                              }
                                              // }
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
