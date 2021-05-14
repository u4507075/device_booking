import 'dart:async';
import 'package:device_booking/firebasedb.dart';
import 'package:device_booking/test.dart';

class SelectLoPage {
  String header;
  String item01;
  String item02;
  String item03;
  String item04;
  String item05;
  String item06;
  String item07;
  String item08;
  String item09;
  String item10;

  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'select_location').then((data) {
      print(data);
      this.header = data['header'];
      this.item01 = data['item01'];
      this.item02 = data['item02'];
      this.item03 = data['item03'];
      this.item04 = data['item04'];
      this.item05 = data['item05'];
      this.item06 = data['item06'];
      this.item07 = data['item07'];
      this.item08 = data['item08'];
      this.item09 = data['item09'];
      this.item10 = data['item10'];
      _controller.add('success');
    });
  }

}