import 'package:get/get.dart';
import './user_model.dart';
import './user_service.dart';
import 'package:device_booking/core/auth/auth.dart';
import './auth.dart';

class UserController extends GetxController {
  Rxn<UserData> _streamUserData = Rxn<UserData>();
  Rxn<UserData> _userData = Rxn<UserData>();
  final Rx<UserLog?> _userLog = UserLog().obs;
  String _userId = '';
  Rx<bool> _developermode = false.obs;

  UserData? get streamUser => _streamUserData.value;
  UserData? get user => _userData.value;
  UserLog? get log => _userLog.value;
  bool get developermode => _developermode.value;

  @override
  void onClose() {
    super.onClose();
    clear();
  }

  @override
  onInit() {
    super.onInit();
    initialize();
  }

  set user(UserData? value) => this._streamUserData.value = value;

  void initialize({bool developermode = false}) async {
    clear();
    if (!developermode) {
      // {_userId = ;
      // do {
      print(
          'UserController initialized: ${Get.find<AuthController>().user?.uid ?? ' '}');
      _streamUserData.bindStream(UserDataService()
              .streamUserData(Get.find<AuthController>().user?.uid ?? ' ') ??
          '' as Stream<UserData>);
      // } while (_streamUserData.value != null);
    } else {
      _developermode.value = true;
      print('developermode: $_developermode');
      _streamUserData.value = UserData.developer();
      _userData.value = UserData.developer();
    }
  }

  void clear() {
    _streamUserData.value = UserData();
  }

  void bindStream() {
    // String? userId = Get.find<AuthController>().user?.uid;
    _streamUserData.bindStream(UserDataService().streamUserData(_userId)!);
  }

  //For sign up
  void updateLocalUser(UserData user) {
    _userData.value = user;
  }

  //fetch user
  Future<void> fetchUser() async {
    _userData.value = await UserDataService()
        .fetchUser(Get.find<AuthController>().firebaseUser!.uid);
  }

  //register new user
  Future<void> registerNewUser({required UserData user}) async {
    await UserDataService().registerNewUser(user);
  }

//update user
  Future<void> updateUser({required UserData? user}) async {
    await UserDataService().updateUser(user ?? '' as UserData);
  }

//delete user
  Future<void> deleteUser(String uid) async {
    await UserDataService().deleteUser(uid);
  }

//user InUse
  void userInUse() {
    streamUser!.inUse = true;
    user!.inUse = true;
  }

//user return
  void userReturn() {
    streamUser!.inUse = false;
    user!.inUse = false;
  }

  Future<UserLog?> lastUserLog() async {
    _userLog.value = await UserDataService()
        .lastUserLog(Get.find<AuthController>().firebaseUser?.uid ?? ' ');
    return _userLog.value;
  }

  void setUser(UserData user) {
    _userData.value = user;
  }
}
