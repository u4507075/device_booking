import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class USER extends ChangeNotifier {
  int count = 0;

  // int get getCounter {
  //   return _count;
  // }

  void increment() {
    count += 1;
    notifyListeners();
  }
}
