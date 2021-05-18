import 'package:device_booking/pages/authenticate/authenticate.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:device_booking/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//listen for auth changes
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either Home or Authenticate widget
    final user = Provider.of<User>(context);
    // print(user);

    if (user != null) {
      return Home();
    } else {
      return Authenticate();
    }
  }
}
