import 'package:device_booking/dev/firebasedb.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class InUsePage {
  String ApPbAr;
  String DU_RaTION;
  String F5;
  String Piggure;
  String UppR_LfT_Button;
  String re;

  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'INusE').then((data) {
      print(data);
      this.ApPbAr = data['ApPbAr'];
      this.DU_RaTION = data['DU_RaTION'];
      this.F5 = data['F5'];
      this.Piggure = data['Piggure'];
      this.UppR_LfT_Button = data['UppR_LfT_Button'];
      this.re = data['re'];
      _controller.add('success');
    });
  }
}
