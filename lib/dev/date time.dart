import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


Future <String> fetchData() async {
  String userid = '300da4192f5db344';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(userid).get();
  if(documentSnapshot.exists){
    Map<String, dynamic> data = documentSnapshot.data();
    String datetime = data["date"];
    var dateTime1 = DateFormat('yyyy-MM-dd hh:mm:ss').parse(datetime);
    final hrs = DateTime.now().difference(dateTime1).inHours;
    final mins = DateTime.now().difference(dateTime1).inMinutes;
    int min = mins%60;
    return '$hrs hours $min minutes';
  }
}



