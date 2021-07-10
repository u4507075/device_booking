import 'package:device_booking/core/core.dart';
import 'package:device_booking/features/features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionRoot extends StatelessWidget {
  // const ConnectionRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return FutureBuilder(
            future: Connectivity().checkConnectivity(),
            builder: (context, snapshot) {
              print('${snapshot.data}');
              return (snapshot.connectionState != ConnectionState.none)
                  ? (snapshot.data != ConnectivityResult.none)
                      ? Root()
                      : NoConnection()
                  : NoConnection();
            });
      },
    );
  }
}

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
