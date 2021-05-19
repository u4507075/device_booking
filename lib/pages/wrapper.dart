import 'package:device_booking/pages/authenticate/authenticate.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:device_booking/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/models/user.dart';

//listen for auth changes
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either Home or Authenticate widget
    final user = Provider.of<UserData>(context);
    // print(user);
    if (user != null && user.phoneNumber != null) {
      //TODO Add verification that user has enter phone number before redirect to Home
      return Home();
    } else {
      return Authenticate();
    }
  }
}
