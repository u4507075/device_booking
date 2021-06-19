import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './user_model.dart';
import './user_service.dart';
import 'package:device_booking/core/auth/auth.dart';
import './auth.dart';

class UserController extends GetxController {
  Rxn<UserData> _streamUserData = Rxn<UserData>();
  Rxn<UserData> _userData = Rxn<UserData>();
  final _userLog = UserLog().obs;
  String _userId = Get.find<AuthController>().user?.uid;

  UserData get streamUser => _streamUserData.value;
  UserData get user => _userData.value;
  UserLog get log => _userLog.value;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  onInit() {
    super.onInit();
    _userId = Get.find<AuthController>().user?.uid;

    _streamUserData.bindStream(UserDataService().streamUserData(_userId));
  }

  set user(UserData value) => this._streamUserData.value = value;

  void clear() {
    _streamUserData.value = UserData();
  }

  void bindStream() {
    String userId = Get.find<AuthController>().user?.uid;
    _streamUserData.bindStream(UserDataService().streamUserData(_userId));
  }

  //For sign up
  void updateLocalUser(UserData user) {
    _userData.value = user;
  }

  //fetch user
  Future<void> fetchUser() async {
    _userData.value = await UserDataService().fetchUser(_userId);
  }

  //register new user
  Future<void> registerNewUser({@required UserData user}) async {
    await UserDataService().registerNewUser(user);
  }

//update user
  Future<void> updateUser({@required UserData user}) async {
    await UserDataService().updateUser(user);
  }

//delete user
  Future<void> deleteUser(String uid) async {
    await UserDataService().deleteUser(uid);
  }

//user InUse
  void userInUse() {
    streamUser.inUse = true;
  }

//user return
  void userReturn() {
    streamUser.inUse = false;
  }

  Future<UserLog> lastUserLog() async {
    _userLog.value = await UserDataService().lastUserLog(_userId);
    return _userLog.value;
  }

  void setUser(UserData user) {
    _userData.value = user;
  }
}
