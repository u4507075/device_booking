import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/core.dart';
import 'navigation/navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/settings/style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppInitialize());
}

class AppInitialize extends StatefulWidget {
  @override
  _AppInitializeState createState() => _AppInitializeState();
}

class _AppInitializeState extends State<AppInitialize> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return InitializeError();
        } // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return App();
        } // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class InitializeError extends StatelessWidget {
  const InitializeError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

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
