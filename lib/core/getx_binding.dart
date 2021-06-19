import 'package:device_booking/core/auth/user.dart';
import 'package:device_booking/core/utils/utils.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/auth/auth.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<LoadingController>(() => LoadingController());
  }
}