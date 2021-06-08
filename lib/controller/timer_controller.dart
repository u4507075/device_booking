import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  // var _now = DateTime.now().obs;
  var _duration = Duration().obs;
  var _count = 0.obs;

  Duration get duration => _duration.value;
  int get count => _count.value;

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

  void countDownSeconds(int seconds) {
    _count.value = seconds;
    Timer.periodic(Duration(seconds: 1), (timer) {
      _count.value -= 1;
      // if (now.isAfter(target)) {
      //   timer.cancel();
      // }
      if (_count.value == 0) {
        timer.cancel();
      }
    });
  }

  void clear() {
    _duration.value = Duration();
  }
}
