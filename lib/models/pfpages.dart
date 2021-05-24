import 'dart:async';
import 'package:device_booking/firebasedb.dart';

class Profilepager {
  String header;
  String text1;
  String text2;
  String text3;
  String text4;
  String button1;
  String button2;

  void fetchAll(StreamController<String> _controller) {
    FirebaseDB()
        .fetchData('pages', 'profile_page')
        .then((data) {
      print(data);
      this.header = data['Header'];
      this.text1 = data['Text_1'];
      this.text2 = data['Text_2'];
      this.text3 = data['Text_3'];
      this.text4 = data['Text_4'];
      this.button1 = data['Button_1'];
      this.button2 = data['Button_2'];
      _controller.add('success');
    });
  }
}