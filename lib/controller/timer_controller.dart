import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  // var _now = DateTime.now().obs;
  var _duration = Duration().obs;

  Duration get duration => _duration.value;

  void timeDifference(DateTime startPoint) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      Duration diff = now.difference(startPoint);
      _duration.value = diff;
    });
  }
}
