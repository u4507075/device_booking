import 'package:device_booking/pages/home/home.dart';
import 'package:flutter/material.dart';

//listen for auth changes
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either Home or Authenticate widget
    return Home(); //logged in
  }
}
