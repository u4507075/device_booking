// import 'package:device_booking/services/firebasedb.dart';

// class LogInPage {
//   final String header;
//   final String subtitle;
//   final String logoPath;
//   final String text;

//   LogInPage(this.header, this.subtitle, this.logoPath, this.text);

//   static LogInPage updateData() {
//     // return LogInPage('header', 'subtitle');
//     FirebaseDB().fetchData('users', '396009414e0329f7');
//   }
// }

// // LogInPage data = LogInPage.updateData();

// // Text(data.header)

import 'package:device_booking/pages/login.dart';
import 'package:device_booking/services/firebasedb.dart';
import 'dart:async';
import 'dart:ui';

class LogInPageModel {
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

  // String getHeader() {
  //   return this.header;
  // }

  // FirebaseDB()
  //     .fetchData('users', '396009414e0329f7')
  //     .then((value) => (Map<String, dynamic> data) {
  //           print(data);
  //         });

}
