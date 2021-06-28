import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/features/home/home.dart';
import 'package:device_booking/features/features.dart';

//listen for auth changes
class Root extends GetWidget<AuthController> {
  // UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    // userController.initialize(developermode: false);
    // print('${userController.user?.firstname}');
    return Obx(() => (!Get.find<LoadingController>().loadingState)
        ? (Get.find<AuthController>().user != null ? Home() : Authenticate())
        : Loading());
  }
}
