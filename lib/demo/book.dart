import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pin.dart';
import 'backhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'alert.dart';

class Book extends StatelessWidget {
  String phone;
  Book(String phone) {
    this.phone = phone;
  }
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.

    return Scaffold(
      // Column is a vertical, linear layout.
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Log in by: " + phone,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: BackHome(),
    );
  }
}
