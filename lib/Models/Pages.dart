import 'package:device_booking/Firebasedb.dart';
import 'dart:async';
class ReportProblemPage {
  String Header;
  String Submit;

  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'Report_problem').then((data) {
      print(data);
      this.Header = data['Header'];
      this.Submit = data['Submit'];
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