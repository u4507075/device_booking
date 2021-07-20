import 'package:async/async.dart';
import 'package:device_booking/core/core.dart';
import 'package:device_booking/core/device/device_service.dart';
import 'package:device_booking/features/features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Root extends StatelessWidget {
  // const Root({Key? key}) : super(key: key);

  // final FutureGroup futureGroup = FutureGroup();
  // final List<Future<dynamic>> futures = [DeviceService().fetchProbeLocation()];

  // FutureGroup initializeApp(Iterable<Future<dynamic>> futures) {
  //   FutureGroup futureGroup = FutureGroup();
  //   futures.forEach((future) => futureGroup.add(future));
  //   futureGroup.close();
  //   return futureGroup;
  // }

  @override
  Widget build(BuildContext context) {
    return checkConnection(
        output: checkAuthStatus(output: checkInUseStatus(output: Home())));
  }
}

Widget checkConnection({required Widget output}) {
  print('check connection');
  return FutureBuilder(
    future: Connectivity().checkConnectivity(),
    builder: (BuildContext context, AsyncSnapshot fSnapshot) {
      return (fSnapshot.hasData)
          ? StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              initialData: fSnapshot.data as ConnectivityResult?,
              builder: (BuildContext context, AsyncSnapshot sSnapshot) {
                ConnectivityResult? result = sSnapshot.data;

                print('Connection changed: $result');
                return (sSnapshot.hasData &&
                        sSnapshot.data != ConnectivityResult.none)
                    ? output
                    : NoConnection();
              },
            )
          : Loading();
    },
  );
}

// Widget checkLoadingStatus({required Widget output}) {
//   //If LoadingState = false => return output
//   return Obx(
//       () => (!Get.find<LoadingController>().loadingState) ? output : Loading());
// }

Widget checkAuthStatus({required Widget output}) {
  print('Check Auth state');
  return Obx(() => Get.find<AuthController>().firebaseUser != null
      ? output
      : Authenticate());
}

Widget checkInUseStatus({required Widget output}) {
  print('Check Use status');
  // return StreamBuilder(
  //   stream: Get.find<UserController>().streamService(),
  //   initialData: UserData(),
  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
  //     return !(snapshot.data.inUse ?? false) ? output : InUse();
  //   },
  // );
  return Obx(() => ((Get.find<UserController>().streamUser != null) &&
          !(Get.find<UserController>().streamUser?.inUse ?? false))
      ? output
      : InUse());
}
