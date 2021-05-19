import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseDB {
  Future<Map<String, dynamic>> fetchData(String field, String document) async {
    CollectionReference doc = FirebaseFirestore.instance.collection(field);
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data();
      return data;
    } else {
      return null;
    }
  }

  void updateStatus(FirebaseApp app, String deviceId) {
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref.child(deviceId).push().set(<String, String>{
      "date": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      //Add user id
      //Add device is
      //Add status borrow / return
    });
  }

  void listenStatusChange(FirebaseApp app, String deviceId) {
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref
        .child(deviceId)
        .limitToLast(1)
        .onChildAdded
        .listen((event) {
      Map<String, dynamic> data = new Map<String, dynamic>.from(
          event.snapshot.value);
      print(data["date"]);
    });
  }

  Future<String> getTime(FirebaseApp app,
      StreamController<String> _controllerTime, String deviceId) {
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref
        .child(deviceId)
        .limitToLast(1)
        .onChildAdded
        .listen((event) {
      Map<String, dynamic> data = new Map<String, dynamic>.from(
          event.snapshot.value);
      print(data["date"]);
      String datetime = data["date"];
      var time = const Duration(milliseconds: 900);
      Timer.periodic(time, (timer)
      {
        var dateTime1 = DateFormat('yyyy-MM-dd hh:mm:ss').parse(datetime);
        final hrs = DateTime
            .now()
            .difference(dateTime1)
            .inHours;
        final mins = DateTime
            .now()
            .difference(dateTime1)
            .inMinutes;
        final secs = DateTime
            .now()
            .difference(dateTime1)
            .inSeconds;
        int min = mins % 60;
        int sec = secs % 60;
        if(hrs == 0) {
          _controllerTime.add('$min minutes $sec secs');
          if(min == 0) {
            _controllerTime.add('$sec secs');
          }else{
            _controllerTime.add('$min minutes $sec secs');
          }
        }else{
          _controllerTime.add('$hrs hours $min minutes $sec secs');
          if(min == 0) {
            _controllerTime.add('$hrs hours $sec secs');
          }else{
            _controllerTime.add('$hrs hours $min minutes $sec secs');
          }
        }
        print('$hrs hours $min minutes $sec secs');
      });
    });
  }
}