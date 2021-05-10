import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


String datetime = "2021-05-10 16:47:43";
var dateTime1 = DateFormat('yyyy-MM-dd hh:mm:ss').parse(datetime);
final hrs = DateTime.now().difference(dateTime1).inHours;
final mins = DateTime.now().difference(dateTime1).inMinutes;
int min = mins%60;

