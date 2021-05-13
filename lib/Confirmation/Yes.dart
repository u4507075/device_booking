import 'package:flutter/material.dart';
import 'package:device_booking/Confirmation/page_nine.dart';

class Yess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfiPage()),
                );
              }),
          title: Text("Confirmation"),
          backgroundColor: Colors.blue,
        ),
        body: Center(child: Text("Y E S")));
  }
}
