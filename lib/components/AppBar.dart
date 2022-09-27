import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

AppBar _getAppBar(context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.shopping_bag,
            color: Color.fromARGB(255, 248, 247, 247),
          ),
          onPressed: () {
            Get.offNamed('/cart');
          },
        )
      ],
      backgroundColor: Colors.black,
      title: Row(
        children: [],
      ),
    );
  }