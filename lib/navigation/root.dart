import 'package:async/async.dart';
import 'package:device_booking/core/core.dart';
import 'package:device_booking/core/device/device_service.dart';
import 'package:device_booking/features/features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectionRoot extends StatelessWidget {
//   // const ConnectionRoot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Connectivity().onConnectivityChanged,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return FutureBuilder(
//             future: Connectivity().checkConnectivity(),
//             builder: (context, snapshot) {
//               print('${snapshot.data}');
//               return (snapshot.connectionState != ConnectionState.none)
//                   ? (snapshot.data != ConnectivityResult.none)
//                       ? Root()
//                       : NoConnection()
//                   : NoConnection();
//             });
//       },
//     );
//   }
// }

// //listen for auth changes
// class Root extends GetWidget<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => (!Get.find<LoadingController>().loadingState)
//         ? (Get.find<AuthController>().firebaseUser != null
//             ? InUseRoot()
//             : Authenticate())
//         : Loading());
//   }
// }

// class InUseRoot extends GetView<UserController> {
//   @override
//   Widget build(BuildContext context) {
//     // return Home();
//     return Obx(
//         () => (controller.streamUser?.inUse ?? false) ? InUse() : Home());
//   }
// }

class Root extends StatelessWidget {
  // const Root({Key? key}) : super(key: key);

  // final FutureGroup futureGroup = FutureGroup();
  final List<Future<dynamic>> futures = [DeviceService().fetchProbeLocation()];

  FutureGroup initializeApp(Iterable<Future<dynamic>> futures) {
    FutureGroup futureGroup = FutureGroup();
    futures.forEach((future) => futureGroup.add(future));
    futureGroup.close();
    return futureGroup;
  }

  @override
  Widget build(BuildContext context) {
    return checkConnection(
        output: checkLoadingStatus(
            output: checkAuthStatus(output: checkInUseStatus(output: Home()))));
  }
}

Widget checkConnection({required Widget output}) {
  return FutureBuilder(
    future: Connectivity().checkConnectivity(),
    initialData: ConnectivityResult.wifi,
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
          : NoConnection();
    },
  );
}

Widget checkLoadingStatus({required Widget output}) {
  //If LoadingState = false => return output
  return Obx(
      () => (!Get.find<LoadingController>().loadingState) ? output : Loading());
}

Widget checkAuthStatus({required Widget output}) {
  // print(Get.find<AuthController>().firebaseUser);
  return Obx(() => Get.find<AuthController>().firebaseUser != null
      ? output
      : Authenticate());
}

Widget checkInUseStatus({required Widget output}) {
  // var controller = Get.put(UserController());
  // return Obx(() => ((controller.streamUser != null) &&
  //         !(controller.streamUser?.inUse ?? false))
  //     ? output
  //     : InUse());

  return Obx(() => ((Get.find<UserController>().streamUser != null) &&
          !(Get.find<UserController>().streamUser?.inUse ?? false))
      ? output
      : InUse());
}
