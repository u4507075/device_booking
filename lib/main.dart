import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/device2.dart';
import 'package:device_booking/models/ultrasounddevice.dart';

import './pages/authenticate/otpverification.dart';
import 'package:device_booking/pages/authenticate/authenticate.dart';
import 'package:device_booking/pages/authenticate/signup.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:device_booking/pages/loading.dart';
import 'package:device_booking/pages/wrapper.dart';
import 'package:device_booking/services/auth.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'pages/authenticate/signup.dart';
import 'package:provider/provider.dart';
import './services/auth.dart';
import './models/user.dart';
// import 'package:device_booking/dev/homepage.dart';
import 'package:device_booking/pages/bookdevice/qrscan.dart';

import 'package:device_booking/services/database.dart';

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
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          initialData: null,
          value: AuthService().onAuthStateChanged,
        ),
        StreamProvider(
          create: (context) {
            return DBService().streamUserData(Provider.of<User>(context,
                    listen: false)
                .uid); //Ref: https://github.com/rrousselGit/provider/issues/120
          },
          initialData: UserData.initialValue(),
          catchError: (context, error) {
            // AuthService().signOut();
            print(error.toString());
            return UserData.initialValue();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Medical Device Tracking System',
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(textTheme: TextTheme(headline1: appBarTextStyle)),
          textTheme: TextTheme(headline1: h1TextStyle, bodyText1: b1TextStyle),
          primaryColor: Colors.blue,
        ),
        initialRoute: '/tester',
        // home: WrapperAuth(),
        routes: {
          '/tester': (context) => Tester(),
          '/wrapper': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/authenticate': (context) => Authenticate(),
          '/loading': (context) => Loading(),
          '/signup': (context) => SignUp(),
          '/getotp': (context) => GetOTP(),
          '/bookdevice/qrscan': (context) => QRScan(),
          // '/bookdevice/selectLo' : (context) => LocationList(),
          // '/bookdevice/busydevice' : (context) => MyTest()
        },
      ),
    );
  }
}

//Function Tester
class Tester extends StatelessWidget {
  const Tester({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                print('Test');
                // UltrasoundDevice().fetchDevice('QxAvyuVhlhdYA8hL0gw0');

                // UltrasoundDevice().takeDevice(
                //     deviceId: 'QxAvyuVhlhdYA8hL0gw0',
                //     userId: 'dNE6ctStgzTeCiZ6YIjVnJGQQJf2',
                //     location: 'บ้าน');

                // Device().fetchDevice('UnJ9w5JS8XnLXOqHhKSv');

                Device().takeDevice(
                    deviceId: 'ZKUFINrPPKGWfZiiFk5E',
                    userId: 'dNE6ctStgzTeCiZ6YIjVnJGQQJf2',
                    location: 'โรงเรียน');

                // Device().addNewDevice(Device().sample());
                // Device().addNewDevice(Device().sample());
              },
              child: Text('Test'))),
    );
  }
}
