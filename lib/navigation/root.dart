import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/features/home/home.dart';
import 'package:device_booking/features/features.dart';

//listen for auth changes
class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().user != null
          ? Home()
          : Authenticate());
    });
    // return Obx(() {
    //   if (Get.find<AuthController>().firebaseUser != null) {
    //     UserController userController = Get.put(UserController());

    //     if (userController.streamUser != null) {
    //       if (Get.find<UserController>().streamUser.inUse) {
    //         return InUse();
    //       } else {
    //         return Home();
    //       }
    //     } else {
    //       return Authenticate();
    //     }
    //   } else {
    //     return Authenticate();
    //   }
    // });
  }
}
