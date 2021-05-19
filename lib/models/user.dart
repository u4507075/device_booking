import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  String firstname;
  String lastname;
  String phoneNumber;
  String role;
  String email;
  String photoURL;
  String uid;

  UserData(
      {this.firstname,
      this.lastname,
      this.phoneNumber,
      this.role,
      this.email,
      this.photoURL,
      this.uid});

  UserData sample() => UserData(
        firstname: 'Sample',
        lastname: '',
        phoneNumber: '',
        role: '',
        email: 'sample@elearning.cmu.ac.th',
        photoURL: '',
        uid: '',
      );
}

class InheritedUserData extends InheritedWidget {
  InheritedUserData({Key key, Widget child, this.user})
      : super(key: key, child: child);

  final UserData user;

  static InheritedUserData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedUserData>();
  }

  @override
  bool updateShouldNotify(InheritedUserData oldWidget) {
    return true;
  }
}
