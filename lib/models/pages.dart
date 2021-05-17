import 'dart:async';
import 'package:device_booking/firebasedb.dart';

class LogInPage {
  String header;
  String logoPath;
  String subtitle;
  String text1;
  String text2;

  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'login').then((data) {
      print(data);
      this.header = data['header'];
      this.logoPath = data['logo'];
      this.subtitle = data['subtitle'];
      this.text1 = data['text'];
      this.text2 = data['text2'];
      _controller.add('success');
    });
  }
  }



