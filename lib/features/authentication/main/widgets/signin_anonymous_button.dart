import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget signInAnonymousButton() {
  return SizedBox(
    width: 300.0,
    child: Card(
      margin: EdgeInsets.all(5.0),
      elevation: 3.0,
      child: ListTile(
        onTap: () async {
          Get.find<AuthController>().signInAnonymously();
        },
        leading: Icon(
          Icons.accessibility_new_sharp,
          color: Color(0xFF02589D),
          size: 40.0,
        ),
        title: Text('Continue Anonymously',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
      ),
    ),
  );
}
