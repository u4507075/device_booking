import 'package:device_booking/Firebasedb.dart';
import 'dart:async';
class ReportProblemPage {
  String Header;
  String Submit;

  void fetchAll(StreamController<String> _controller) {
    FirebaseDB().fetchData('pages', 'Report problem').then((data) {
      print(data);
      this.Header = data['Header'];
      this.Submit = data['Submit'];
      _controller.add('success');
    });
  }
}