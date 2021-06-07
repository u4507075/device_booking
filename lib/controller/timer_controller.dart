import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  // var _now = DateTime.now().obs;
  var _duration = Duration().obs;

  Duration get duration => _duration.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  //Count up
  void timeDifference(DateTime startPoint) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      Duration diff = now.difference(startPoint);
      _duration.value = diff;
    });
  }

  void countDown(Duration duration) {
    DateTime target = DateTime.now().add(duration);
    Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      Duration diff = target.difference(now);
      _duration.value = diff;
      if (now.isAfter(target)) {
        timer.cancel();
      }
    });
  }

  void clear() {
    _duration.value = Duration();
  }
}
