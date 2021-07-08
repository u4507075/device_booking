import 'package:device_booking/core/core.dart';
import 'package:device_booking/features/features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

//listen for auth changes
class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => (!Get.find<LoadingController>().loadingState)
        ? (Get.find<AuthController>().user != null
            ? InUseRoot()
            : Authenticate())
        : Loading());
  }
}

class InUseRoot extends GetWidget<UserController> {
  var userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => (userController.streamUser?.inUse ?? false) ? InUse() : Home());
  }
}
// class ConnectivityCheckRoot extends StatelessWidget {
//   // const ConnextivityCheckRoot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: null,
//     );
//   }
// }
