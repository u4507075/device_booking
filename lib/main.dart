import 'package:device_booking/Confirmation/page_nine.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      //home: MyTestBook(),
      home: ConfiPage(),
    );
  }
}

