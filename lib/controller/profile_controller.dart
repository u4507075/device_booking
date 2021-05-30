import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/user.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  List<List<String>> _profileList;

  get profileList => _profileList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    UserData user = Get.find<UserController>().user;
    _profileList = [
      ['First name', user?.firstname],
      ['Last name', user?.lastname],
      ['Tel.', user?.phoneNumber],
      ['Role', user?.role]
    ];
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void clear() {
    _profileList = [[]];
  }
}
