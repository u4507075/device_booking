import 'package:device_booking/firebasedb.dart';
import 'dart:async';

class TestData {
  String IM1;
  String IM2;
}

void fetchAll(StreamController<String> _controller) {
  FirebaseDB().fetchData('uqxXjSEU2JpgXpcaJfPF', 'operatingZone').then((data) {
    print(data);


