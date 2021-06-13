import 'package:device_booking/controller/auth_controller.dart';
import 'package:device_booking/controller/loading_controller.dart';
import 'package:device_booking/controller/phoneauth_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<PhoneAuthController>(PhoneAuthController(), permanent: true);
    Get.put<LoadingController>(LoadingController(), permanent: true);
  }
}
