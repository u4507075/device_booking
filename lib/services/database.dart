import 'package:device_booking/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/models/user.dart';

class DBService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  //Get UserData one time
  Future<UserData> getUser(String id) async {
    var snap = await _db.collection('users').doc(id).get();
    return UserData.fromMap(snap.data());
  }

  Future<bool> checkUser(String id) {
    return _db.collection('users').doc(id).get().then((snap) {
      return snap.exists;
    });
  }

  //Stream UserData
  Stream<UserData> streamUserData(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => UserData.fromMap(snap.data()));
  } //ref: https://www.youtube.com/watch?v=vFxk_KJCqgk ['Provider and flutterfire']

  Future<void> addUser(UserData userData) {
    _db.collection('users').add({
      'firstname': userData.firstname,
      'lastname': userData.lastname,
      'email': userData.email,
      'phoneNumber': userData.phoneNumber,
      'role': userData.role,
      'uid': userData.uid,
    });
  }
}
