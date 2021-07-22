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
        output: checkAuthStatus(output: checkUserStatus(output: Home())));
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
  return Obx(
    () => Get.find<AuthController>().firebaseUser != null
        ? output
        : Authenticate(), //? User have not signed in
  );
}

Widget checkUserStatus({required Widget output}) {
  print('Check Use status');

  return Obx(
    () => ((Get.find<UserController>().streamUser?.uid == ''))
        ? Authenticate() //? User is not registered, close during sign up page
        : (Get.find<UserController>().streamUser?.inUse ?? false)
            ? InUse() //? User.inUser = true -> InUsePage
            : output, //? User.inUser = false -> Home
  );
}

// Widget checkUserCompleted({required Widget output}) {
//   return FutureBuilder(
//     future: Get.find<UserController>().fetchUser(),
//     // initialData: InitialData,
//     builder: (BuildContext context, AsyncSnapshot snapshot) {
//       UserData? user = snapshot.data;
//       if (snapshot.hasData &&
//           snapshot.connectionState == ConnectionState.done) {
//             return (user!=null || user.isCompleted)?output :Get.find<AuthController>().signOut();
//         return ;
//       }
//     },
//   );
// }
