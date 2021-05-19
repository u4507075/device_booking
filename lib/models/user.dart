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
        lastname: 'Sample',
        phoneNumber: '0981234567',
        role: 'Intern',
        email: 'sample@elearning.cmu.ac.th',
        photoURL:
            'https://th.jobsdb.com/th-th/cms/employer/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png',
        uid: 'sdfluioASDFiosdfadsf',
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
