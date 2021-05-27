import 'package:device_booking/models/pages/pages.dart';
import 'package:device_booking/pages/authenticate/authenticate.dart';
import 'package:device_booking/pages/authenticate/signup.dart';
import 'package:device_booking/pages/bookdevice/InUse.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:device_booking/pages/loading.dart';
import 'package:device_booking/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/models/user/user.dart';

//listen for auth changes
class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null) {
      //Google signed in
      final userData = Provider.of<UserData>(context);

      if (userData.phoneNumber.length < 10 ||
          userData.phoneNumber.substring(0, 1) != '0') {
        return SignUp();
      } else {
        return Home();
      }
    } else {
      return Authenticate();
    }

  }
}

// class WrapperSignUp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //return either Home or Authenticate widget
//     final user = Provider.of<User>(context);
//     final userData = context.watch<UserData>();
//     // print(user);
//     print('username ${userData?.firstname}');
//     if (user != null &&
//         userData?.phoneNumber != null &&
//         userData?.firstname != null &&
//         userData?.lastname != null &&
//         userData?.role != null) {
//       //TODO Add verification that user has enter phone number before redirect to Home
//       print('User Signed up');
//       return Home();
//       // } else if (user != null && userData?.phoneNumber == '') {
//       //   print('to Sign up page');
//       //   return SignUp();
//     } else {
//       print('Incompleted Sign Up');
//       return Authenticate();
//     }
//   }
// }
