import 'package:device_booking/services/firebasedb.dart';
import 'dart:async';

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
  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'INusE').then((data) {
      print(data);
      this.ApPbAr = data['ApPbAr'];
      this.DU_RaTION = data['DU_RaTION'];
      this.Piggure = data['Piggure'];
      this.UppR_LfT_Button = data['UppR_LfT_Button'];
      this.re = data['re'];
      _controller.add('success');
    });
  }
}


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