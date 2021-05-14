import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';

class FirebaseDB {
  Future <Map<String, dynamic>> fetchData(String field, String document) async {
    CollectionReference doc = FirebaseFirestore.instance.collection(field);
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data();
      return data;
    }
    else{
      return null;
    }
  }
  void updateStatus(FirebaseApp app, String deviceId){
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref.child(deviceId).push().set(<String, String>{"date":DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())});
  }
  void listenStatusChange(FirebaseApp app,String deviceId){
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref.child(deviceId).limitToLast(1).onChildAdded.listen((event) {
      Map<String, dynamic> data = new Map<String, dynamic>.from(event.snapshot.value);
      print(data["date"]);
    });
  }
}
