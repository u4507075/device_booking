export 'root.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';
import './navigation.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

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
        initialBinding: AllBindings(),
        initialRoute: '/',
        getPages: [
          //   GetPage(
          //       name: 'tester', page: () => Tester()), //Test field for new function
          GetPage(name: '/', page: () => Root()),
          //   GetPage(name: '/loading', page: () => Loading()), //Global loading page

          //   //Sign in features
          //   GetPage(name: 'authenticate', page: () => Authenticate()),
          //   GetPage(name: '/signup', page: () => SignUp()),
          //   GetPage(name: '/home', page: () => Home()),
          //   GetPage(name: '/getotp', page: () => GetOTP()),

          //   //Device info features
          //   GetPage(name: '/devicelist', page: () => DeviceListPage()),
          //   GetPage(name: '/deviceinfo', page: () => DeviceInfo()),
          //   GetPage(name: '/reportproblem', page: () => ReportProblem()),

          //   //Take device features
          //   GetPage(name: '/takedevice', page: () => TakeDevice()),
          //   GetPage(name: '/selectlocation', page: () => SelectLocation()),
          //   GetPage(name: '/confirmation', page: () => Confirmation()),
          //   GetPage(name: '/inuse', page: () => InUse()),
          //   GetPage(name: '/busydevice', page: () => BusyDevice()),

          //   //Profile features
          //   GetPage(name: '/profile', page: () => Profile()),
          // GetPage(name: '/editprofile', page: () => EditProfile()),
        ]);
  }
}

