import 'package:device_booking/dev/firebasedb.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class QRScanPage {
  String Brrr;
  String Copy;
  String Result;
  String Scan;
  String Start;


  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'QR_reader').then((data) {
      print(data);
      this.Brrr = data['Brrr'];
      this.Copy = data['Copy'];
      this.Result = data['Result'];
      this.Scan = data['Scan'];
      this.Start = data['Start'];
      _controller.add('success');
    });
  }
}
