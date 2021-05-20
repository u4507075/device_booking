import 'package:device_booking/services/database.dart';
import 'dart:async';
import 'package:device_booking/FirebaseDB.dart';

class BusyDevice {
  String Header;
  String Picture;
  String Subheader_1;
  String Text_1;
  String Text_2;
  String Text_3;
  String Subheader_2;
  String Suby;
  String Button_1;
  String Button_2;
  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'Busy Device').then((data) {
      print(data);
      this.Header = data['Header'];
      this.Picture = data['Picture'];
      this.Subheader_1 = data['Subheader_1'];
      this.Text_1 = data['Text_1'];
      this.Text_2 = data['Text_2'];
      this.Text_3 = data['Text_3'];
      this.Subheader_2 = data['Subheader_2'];
      this.Suby = data['Suby'];
      this.Button_1 = data['Button_1'];
      this.Button_2 = data['Button_2'];
      _controller.add('success');
    });
  }
}