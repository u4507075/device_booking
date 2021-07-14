import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  // var _now = DateTime.now().obs;
  var _duration = Duration().obs;
  var _count = 0.obs;
  var _timeout = false.obs;

  Duration get duration => _duration.value;
  int get count => _count.value;
  bool get timeout => _timeout.value;

  @override
  void onInit() {
   
    super.onInit();
    countDownSeconds();
    _timeout.value = false;
  }

  @override
  void onClose() {
    
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

  void countDownSeconds({int seconds = 60}) {
    _count.value = seconds;
    Timer.periodic(Duration(seconds: 1), (timer) {
      _count.value -= 1;
      // if (now.isAfter(target)) {
      //   timer.cancel();
      // }
      if (_count.value == 0) {
        timer.cancel();
        this._timeout.value = true;

        // Get.back();
      }
    });
  }

  void clear() {
    _duration.value = Duration();
  }
}
