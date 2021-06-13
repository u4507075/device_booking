import 'package:device_booking/controller/auth_controller.dart';
import 'package:device_booking/controller/loading_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/pages/authenticate/authenticate.dart';
import 'package:device_booking/pages/bookdevice/inuse.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:device_booking/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//listen for auth changes
class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<LoadingController>().loadingState) {
        return Loading();
      } else {
        return Obx(() {
          if (Get.find<AuthController>().firebaseUser != null) {
            UserController userController = Get.put(UserController());
            // print(userController.streamUser);
            // print(Get.find<AuthController>().firebaseUser?.uid);
            if (Get.find<UserController>().streamUser != null) {
              userController.fetchUser();
              if (Get.find<UserController>().streamUser.inUse) {
                print(1);
                return InUse();
              } else {
                print(2);
                return Home();
              }
            } else {
              print(3);
              Get.find<UserController>()
                  .bindStream(); //Re-bind stream with new value
              return Authenticate();
            }
          } else {
            print(4);
            return Authenticate();
          }
        });
      }
    });

    // if (Get.find<AuthController>().firebaseUser != null) {
    //   UserController userController = Get.put(UserController());
    //   userController.fetchUser();
    //   if (userController.streamUser != null) {
    //     if (Get.find<UserController>().streamUser.inUse) {
    //       return InUse();
    //     } else {
    //       return Home();
    //     }
    //   } else {
    //     return Authenticate();
    //   }
    // } else {
    //   return Authenticate();
    // }
  }
}
