import 'package:device_booking/controller/bindings/authBinding.dart';
import 'package:device_booking/controller/count_controller.dart';
import 'package:device_booking/models/pages/pages.dart';
import 'package:device_booking/pages/bookdevice/busydevice.dart';
import 'package:device_booking/pages/bookdevice/inuse.dart';
import 'package:device_booking/pages/bookdevice/confirmation.dart';

import 'package:device_booking/pages/deviceinfo/reportproblem.dart';
import 'package:device_booking/pages/bookdevice/selectlocation.dart';
import 'package:device_booking/utils/takedeviceroot.dart';
import 'package:device_booking/pages/deviceinfo/deviceinfo.dart';
import 'package:device_booking/pages/deviceinfo/devicelist.dart';
import 'package:device_booking/pages/profile/editprofile.dart';
import 'package:device_booking/pages/profile/profile.dart';

import 'package:device_booking/pages/authenticate/authenticate.dart';
import 'package:device_booking/pages/authenticate/signup.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:device_booking/utils/loading.dart';
import 'package:device_booking/utils/root.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'pages/authenticate/signup.dart';
// import 'package:device_booking/dev/homepage.dart';

import 'package:get/get.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('google_fonts/roboto_LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db',
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
            appId: '1:780797690669:ios:b2cdff48c7ca58a231c9a4',
            apiKey: 'AIzaSyB2FxL38uNcqlhuRql7fJHceaSBeIUDBgU',
            projectId: 'med-cmu-device-tracking-system',
            messagingSenderId: '780797690669',
            databaseURL:
                'https://med-cmu-device-tracking-system-default-rtdb.asia-southeast1.firebasedatabase.app',
          )
        : const FirebaseOptions(
            appId: '1:780797690669:android:33ab63eb3bed0cd131c9a4',
            apiKey: 'AIzaSyDiCLAMpx1JS4AHNdw0rWhgOf6HxD_EvCs',
            messagingSenderId: '780797690669',
            projectId: 'med-cmu-device-tracking-system',
            databaseURL:
                'https://med-cmu-device-tracking-system-default-rtdb.asia-southeast1.firebasedatabase.app',
          ),
  );
  runApp(MyApp(app: app));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.app}) : super(key: key);
  final FirebaseApp app;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Medical Device Tracking System',
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(textTheme: TextTheme(headline1: appBarTextStyle)),
        textTheme: TextTheme(
            headline1: h1TextStyle,
            headline2: h2TextStyle,
            headline3: h3TextStyle,
            bodyText1: b1TextStyle,
            bodyText2: b2TextStyle),
        primaryColor: Colors.blue,
      ),
      initialBinding: AuthBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: 'tester', page: () => Tester()), //Test field for new function
        GetPage(name: '/', page: () => Root()),
        GetPage(name: '/loading', page: () => Loading()), //Global loading page

        //Sign in features
        GetPage(name: 'authenticate', page: () => Authenticate()),
        GetPage(name: '/signup', page: () => SignUp()),
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/getotp', page: () => GetOTP()),

        //Device info features
        GetPage(name: '/devicelist', page: () => DeviceListPage()),
        GetPage(name: '/deviceinfo', page: () => DeviceInfo()),
        GetPage(name: '/reportproblem', page: () => ReportProblem()),

        //Take device features
        GetPage(name: '/takedevice', page: () => TakeDevice()),
        GetPage(name: '/selectlocation', page: () => SelectLocation()),
        GetPage(name: '/confirmation', page: () => Confirmation()),
        GetPage(name: '/inuse', page: () => InUse()),
        GetPage(name: '/busydevice', page: () => BusyDevice()),

        //Profile features
        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/editprofile', page: () => EditProfile()),
      ],
    );
  }
}

//Function Tester
class Tester extends StatelessWidget {
  final CountController countController = Get.put(CountController());
  @override
  Widget build(BuildContext context) {
    // var counter = Provider.of<USER>(context).count;
    // var count = context.watch<USER>().count;
    String deviceId = '123';
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetBuilder<CountController>(
              init: CountController(),
              builder: (controller) {
                return Text('${controller.count ?? ''}');
              }),
          ElevatedButton(
              onPressed: () {
                print('Test');
                countController.increment();
                Get.to(() => DeviceInfo(), arguments: deviceId);

                // Get.find<DeviceController>().setId('');

                // Get.find<DeviceController>().setId('');

                // Device().fetchDevice('UnJ9w5JS8XnLXOqHhKSv');

                // Device().takeDevice(
                //     deviceId: 'ZKUFINrPPKGWfZiiFk5E',
                //     userId: 'dNE6ctStgzTeCiZ6YIjVnJGQQJf2',
                //     location: 'โรงเรียน');

                // Device().returnDevice(
                //     deviceId: 'ZKUFINrPPKGWfZiiFk5E',
                //     userId: 'dNE6ctStgzTeCiZ6YIjVnJGQQJf2');

                // Device().reportDevice(
                //     deviceId: 'ZKUFINrPPKGWfZiiFk5E',
                //     userId: 'dNE6ctStgzTeCiZ6YIjVnJGQQJf2',
                //     reportText: 'เครื่องหนักจังเลย');

                // Device().addNewDevice(Device().sample());
                // Device().addNewDevice(Device().sample());

                // DBService().fetchDeviceList('ultrasound').then((devices) {
                //   devices.forEach((device) {
                //     print(device.name);
                //   });
                // });
              },
              child: Text('Test')),
          ElevatedButton(
              onPressed: () {
                deviceId = '6PpTwPAVDtVswJ13aCOo';
                Get.to(() => DeviceInfo(), arguments: deviceId);
              },
              child: Text('Device 1')),
          ElevatedButton(
              onPressed: () {
                deviceId = '7qfPYOiGbJWQAddGpN9x';
                Get.to(() => DeviceInfo(), arguments: deviceId);
              },
              child: Text('Device 2'))
        ],
      )),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key key, this.app}) : super(key: key);
//   final FirebaseApp app;

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         StreamProvider<User>.value(
//           initialData: null,
//           value: AuthService().onAuthStateChanged,
//         ),
//         // StreamProvider(
//         //   create: (context) {
//         //     return DBService().streamUserData(Provider.of<User>(context,
//         //             listen: false)
//         //         .uid); //Ref: https://github.com/rrousselGit/provider/issues/120
//         //   },
//         //   initialData: UserData.initialValue(),
//         //   catchError: (context, error) {
//         //     // AuthService().signOut();
//         //     print(error.toString());
//         //     return UserData.initialValue();
//         //   },
//         // ),
//         StreamProvider<UltrasoundDeviceList>(
//             create: (context) => UltrasoundDeviceList().streamDeviceList(),
//             initialData: UltrasoundDeviceList.initialValue()),
//         StreamProvider<EkgDeviceList>(
//             create: (context) => EkgDeviceList().streamDeviceList(),
//             initialData: EkgDeviceList.initialValue())
//       ],
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: true,
//         title: 'Medical Device Tracking System',
//         theme: ThemeData(
//           appBarTheme:
//               AppBarTheme(textTheme: TextTheme(headline1: appBarTextStyle)),
//           textTheme: TextTheme(headline1: h1TextStyle, bodyText1: b1TextStyle),
//           primaryColor: Colors.blue,
//         ),
//         initialRoute: '/',
//         // home: WrapperAuth(),
//         routes: {
//           'tester': (context) => Tester(),
//           '/': (context) => Wrapper(),
//           '/home': (context) => Home(),
//           '/authenticate': (context) => Authenticate(),
//           '/loading': (context) => Loading(),
//           '/signup': (context) => SignUp(),
//           '/getotp': (context) => GetOTP(),
//           '/bookdevice/qrscan': (context) => QRScan(),
//           'checkuserdevice': (context) => CheckDeviceInfo(),
//           'getotp': (context) => GetOTP2(),
//           '/home/devicelist': (context) => DeviceListPage(),
//           // '/bookdevice/selectLo' : (context) => LocationList(),
//           // '/bookdevice/busydevice' : (context) => MyTest()
//         },
//         getPages: [
//           GetPage(name: '/', page: () => Wrapper()),
//           GetPage(name: 'tester', page: () => Tester()),
//           GetPage(name: '/home', page: () => Home()),
//           GetPage(name: 'authenticate', page: () => Authenticate()),
//           GetPage(name: '/loading', page: () => Loading()),
//           GetPage(name: '/qrscan', page: () => QRScan()),
//           GetPage(name: '/signup', page: () => SignUp()),
//           GetPage(name: '/devicelist', page: () => DeviceListPage()),
//         ],
//       ),
//     );
//   }
// }
