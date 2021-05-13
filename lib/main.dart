import 'package:device_booking/pages/reportproblem.dart';
import 'package:device_booking/loading.dart';
import 'package:device_booking/smscode.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/home.dart';
import 'package:device_booking/getotp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/book.dart';
import 'dart:async';
import 'dart:io';
import 'package:device_booking/test.dart';
import 'package:device_booking/status.dart';
import 'package:device_booking/dev/qrscan.dart';
import 'package:device_booking/dev/homepage.dart';
import 'pages/welcome.dart';
import 'pages/ultrasoundstatus.dart';
import 'src/button.dart';
import 'package:device_booking/services/firebasedb.dart';

void main() async {
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseDB2().fetchData('users', '396009414e0329f7');

    // FirebaseDB()
    //     .fetchData('users', '396009414e0329f7')
    //     .then((value) => (Map<String, dynamic> data) {
    //           print(data);
    //         });

    // FirebaseDB().updateStatus(app, 'spatipan');

    // FirebaseDB().listenStatusChange(app, 'Sun');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: Home(),
      //home: GetOTP(),
      //home: Book('992106606'),
      //home: Load(),
      // home: Status(app, 'deviceid1'),
      // home: QRScanPage(),
      // home: HomePage(),
      // home: Welcome(),
      // home: UltrasoundStatus(),
      // home: HomeTest(),
      //home: Status(app,'deviceid1'),
      home: ReportProblem(),
    );
  }
}

class HomeTest extends StatelessWidget {
  //const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // children: [CardStatus()],
      ),
    );
  }
}

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Text 1'),
        Text('Text 2'),
        Card(
          elevation: 3.0,
          child: OutlinedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.login_rounded,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('Continue with Google')
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
