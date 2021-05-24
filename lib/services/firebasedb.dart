import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/models/Userdetail.dart';

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
    ref.child(deviceId).limitToLast(1).onChildAdded.listen((event) {
      Map<String, dynamic> data =
          new Map<String, dynamic>.from(event.snapshot.value);
      print(data["date"]);
    });
  }

  Future<UserDetails> fetchUserDetails(String document) async {
    CollectionReference doc = FirebaseFirestore.instance.collection('users_testpull');
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> users_testpull = documentSnapshot.data();
      return UserDetails(
          email: users_testpull['email'],
          firstname: users_testpull['firstname'],
          imagePath: users_testpull['imagePath'],
          lastname: users_testpull['lastname'],
          role: users_testpull['role'],
          telephone: users_testpull['telephone']);
    } else {
      return null;
    }
  }
}
