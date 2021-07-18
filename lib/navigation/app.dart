export 'root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';
import './navigation.dart';
import 'package:device_booking/features/features.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Lock screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //Fetch necessary data befor app initialize

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
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
          primaryColor: Color.fromARGB(255, 48, 98, 153),
          iconTheme: IconThemeData(
            // color: Colors.blue,
            size: 20,
          ),
        ),
        initialBinding: AllBindings(),
        initialRoute: '/',
        getPages: [
          GetPage(
              name: 'tester',
              page: () => Tester()), //Test field for new function
          GetPage(name: '/', page: () => Root()),
          GetPage(
              name: '/loading', page: () => Loading()), //Global loading page

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
          GetPage(name: '/takedevice', page: () => TakeDeviceRoot()),
          GetPage(name: '/selectlocation', page: () => SelectLocation()),
          GetPage(name: '/confirmation', page: () => Confirmation()),
          GetPage(name: '/inuse', page: () => InUse()),
          GetPage(name: '/busydevice', page: () => BusyDevice()),

          //Profile features
          GetPage(name: '/profile', page: () => Profile()),
          GetPage(name: '/editprofile', page: () => EditProfile()),

          //Additional function
          GetPage(name: '/faq', page: () => Faq()),
          GetPage(name: '/help', page: () => Help()),
          GetPage(name: '/feedback', page: () => FeedBack()),
        ]);
  }
}
