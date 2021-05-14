import 'package:device_booking/dev/firebasedb.dart';
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

class InUsePage {
  String ApPbAr;
  String DU_RaTION;
  String Piggure;
  String UppR_LfT_Button;
  String re;
  String date;


  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'INusE').then((data) {
      print(data);
      this.ApPbAr = data['ApPbAr'];
      this.DU_RaTION = data['DU_RaTION'];
      this.Piggure = data['Piggure'];
      this.UppR_LfT_Button = data['UppR_LfT_Button'];
      this.re = data['re'];
      this.date = data['date'];
      _controller.add('success');
    });
  }
}
