import 'package:flutter/material.dart';
import 'backhome.dart';

class Book extends StatefulWidget {
  final String phone;
  Book(this.phone);

  @override
  _BookState createState() => _BookState(phone: phone);
}

class _BookState extends State<Book> {
  String phone;

  _BookState({this.phone});

  // _BookState(this.phone);

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
