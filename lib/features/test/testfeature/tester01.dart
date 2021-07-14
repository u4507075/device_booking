import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';
import 'package:get/get.dart';

class Tester1 extends StatelessWidget {
  var userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          print(userController.streamUser?.firstname);
          print(userController.streamUser?.isCompleted);
        },
        child: Text('Check user'),
      )),
    );
  }
}
