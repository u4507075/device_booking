import 'package:device_booking/controller/auth_controller.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/models/user.dart';

class UserController extends GetxController {
  Rxn<UserData> _userData = Rxn<UserData>();

  UserData get user => _userData.value;

  @override
  onInit() {
    super.onInit();
    String userId = Get.find<AuthController>().firebaseUser.uid;
    _userData.bindStream(DBService().streamUserData(userId));
  }

  set user(UserData value) => this._userData.value = value;

  void clear() {
    _userData.value = UserData();
  }

  //register new user
  Future<void> registerNewUser({@required UserData user}) async {
    await DBService().registerNewUser(user);
  }

//update user
  Future<void> updateUser({@required UserData user}) async {
    await DBService().updateUser(user);
    UserData _user;
  }

//delete user
  Future<void> deleteUser(String uid) async {
    await DBService().deleteUser(uid);
  }

//user InUse
  void userInUse() {
    user.inUse = true;
  }

//user return
  void userReturn() {
    user.inUse = false;
  }
}
