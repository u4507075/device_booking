import 'package:device_booking/dev/controller/auth_controller.dart';
import 'package:device_booking/dev/controller/user_controller.dart';
import 'package:device_booking/dev/pages/authenticate/authenticate.dart';
import 'package:device_booking/dev/pages/bookdevice/inuse.dart';
import 'package:device_booking/dev/pages/home/home.dart';
import 'package:device_booking/dev/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//listen for auth changes
class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().firebaseUser != null
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
