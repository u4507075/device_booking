import 'package:device_booking/services/auth.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserData extends ChangeNotifier implements ReassembleHandler {
  String firstname;
  String lastname;
  String phoneNumber;
  String role;
  String email;
  String photoURL;
  String uid;
  bool inUse;

  UserData({
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.role,
    this.email,
    this.photoURL,
    this.uid,
    this.inUse,
  });

  @override
  void reassemble() {
    print('Did Hot Reload');
  }

  factory UserData.fromMap(Map map) {
    return UserData(
      firstname: map['firstname'] ?? null,
      lastname: map['lastname'] ?? null,
      phoneNumber: map['phoneNumber'] ?? null,
      role: map['role'] ?? null,
      email: map['email'] ?? null,
      photoURL: map['photoURL'] ?? null,
      uid: map['uid'] ?? null,
      inUse: map['inUse'] ?? null,
    );
  }

  factory UserData.initialValue() => UserData(
        firstname: null,
        lastname: null,
        phoneNumber: null,
        role: null,
        email: null,
        photoURL: null,
        uid: null,
        inUse: false,
      );

  // bool iscom(){

  // }

  bool isCompleted(UserData user) {
    // print(user.firstname);
    // print(user.lastname);
    // print(user.phoneNumber);
    // print(user.role);
    if (user.firstname != null ||
        user.lastname != null ||
        user.phoneNumber != null ||
        user.role != null) {
      if (user.firstname.length < 2 ||
          user.lastname.length < 2 ||
          user.phoneNumber.length < 10 ||
          user.role.length < 3) {
        print("Incompleted user data");
        return false;
      } else {
        print('Completed user data');
        return true;
      }
    } else {
      print("Data not found");
      return false;
    }
  }

  void updateFirstName(UserData userData) {
    print('before ${userData.firstname}');
    firstname = userData.firstname;
    print('after $firstname');
    notifyListeners();
  }

  void transferFromFireBaseUser(User fbUser) {
    var user = AuthService().userDataFromFirebaseUser(fbUser);
    firstname = user?.firstname;
    lastname = user?.lastname;
    phoneNumber = user?.phoneNumber;
    role = user?.role;
    email = user?.email;
    photoURL = user?.photoURL;
    uid = user?.uid;
    inUse = false;
    notifyListeners();
  }

//register new user
  Future<void> registerNewUser({@required UserData user}) async {
    await DBService().registerNewUser(user);
    firstname = user.firstname;
    lastname = user.lastname;
    phoneNumber = user.phoneNumber;
    role = user.role;
    email = user.email;
    photoURL = user.photoURL;
    uid = user.uid;
    inUse = false;
    notifyListeners();
  }

//update user
  Future<void> updateUser({@required UserData user}) async {
    await DBService().updateUser(user);
    firstname = user.firstname;
    lastname = user.lastname;
    role = user.role;
    photoURL = user.photoURL;
    notifyListeners();
  }

//fetch user
  Future<UserData> fetchUser({@required String userId}) async {
    try {
      UserData user = await DBService().fetchUser(userId);
      // print(user.firstname);
      firstname = user?.firstname;
      lastname = user?.lastname;
      phoneNumber = user?.phoneNumber;
      role = user?.role;
      email = user?.email;
      photoURL = user?.photoURL;
      uid = user?.uid;
      inUse = false;
      notifyListeners();
      return user;
    } catch (e) {
      print('user not found, ${e.toString()}');
      return null;
    }
  }

//user InUse
  void userInUse() {
    inUse = true;
    notifyListeners();
  }

//user return
  void userReturn() {
    inUse = false;
    notifyListeners();
  }

// class Userlog {
//   String userId;
//   String deviceId;
//   bool take;
//   DateTime time;

//   Userlog({this.userId, this.deviceId, this.take, this.time});
// }

}
