import 'package:device_booking/controller/auth_controller.dart';
import 'package:device_booking/services/database.dart';
import 'package:get/get.dart';
import 'package:device_booking/models/user/user.dart';

class UserController extends GetxController {
  Rxn<UserData> _userData = Rxn<UserData>();
  // String userId;
  UserData get user => _userData.value;
  // UserController(this.userId);

  @override
  onInit() {
    super.onInit();
    String userId = Get.find<AuthController>().firebaseUser?.uid;
    _userData.bindStream(DBService().streamUserData(userId));
  }

  set user(UserData value) => this._userData.value = value;

  void clear() {
    _userData.value = UserData();
  }
}
