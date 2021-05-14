import 'package:device_booking/firebasedb.dart';
import 'dart:async';

class ConfirmBook {
  String header;
  String subheader_1;
  String subheader_2;
  String subheader_3;
  String picture;
  String button_1;
  String button_2;
  String text_1;
  String text_2;
  String text_3;

  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'Confirm').then((data) {
      print(data);
      this.header = data['Header'];
      this.subheader_1 = data['Subheader_1'];
      this.subheader_2 = data['Subheader_2'];
      this.subheader_3 = data['Subheader_3'];
      this.picture= data['Picture'];
      this.button_1 = data['Button_1'];
      this.button_2 = data['Button_2'];
      this.text_1 = data['Text_1'];
      this.text_2 = data['Text_2'];
      this.text_3 = data['Text_3'];
      _controller.add('success');
    });
  }

}