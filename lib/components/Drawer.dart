import 'package:bayfrontend/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

Widget sideDrawer(
  BuildContext context,
) {
  return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: ListView(children: <Widget>[
        ListTile(
          title: const Text('Home'),
          leading: const Icon(Icons.home),
          onTap: () {
            Get.offNamed('/dashboard');
          },
        ),
        ListTile(
          title: const Text('All Users'),
          leading: const Icon(Icons.people),
          onTap: () {
            Get.offNamed("/allUsers");
          },
        ),
        ListTile(
          title: const Text('Todays Sales'),
          leading: const Icon(Icons.money),
          onTap: () {
            Get.offNamed('/sales');
          },
        ),
        ListTile(
          title: const Text('All Service'),
          leading: const Icon(Icons.room_service),
          onTap: () {
            Get.offNamed('/allService');
          },
        ),
        SizedBox(
          height: 80,
        ),
        ListTile(
          title: ElevatedButton.icon(
            // <-- ElevatedButton
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 224, 218, 218),
            ),
            onPressed: () async {
              await AuthService.removeToken();
              await Get.offNamed('/admin/login');
            },
            icon: Icon(
              Icons.logout,
              size: 24.0,
              color: Color.fromARGB(255, 19, 18, 18),
            ),
            label: Text('Logout',
                style: TextStyle(color: Color.fromARGB(255, 26, 25, 25))),
          ),
        )
      ]));
}

Widget SalesDrawer(
  BuildContext context,
) {
  return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: ListView(children: <Widget>[
        ListTile(
          title: const Text('Home'),
          leading: const Icon(Icons.home),
          onTap: () {
            Get.offNamed('/SalesPage');
          },
        ),
        // ListTile(
        //   title: const Text('Todays Sales'),
        //   leading: const Icon(Icons.money),
        //   onTap: () {
        //     Get.offNamed('/sales');
        //   },
        // ),
        SizedBox(
          height: 80,
        ),
        ListTile(
          title: ElevatedButton.icon(
            // <-- ElevatedButton
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 224, 218, 218),
            ),
            onPressed: () async {
              await AuthService.removeToken();
              await await Get.offNamed('/login');
            },
            icon: Icon(
              Icons.logout,
              size: 24.0,
              color: Color.fromARGB(255, 19, 18, 18),
            ),
            label: Text('Logout',
                style: TextStyle(color: Color.fromARGB(255, 26, 25, 25))),
          ),
        )
      ]));
}
