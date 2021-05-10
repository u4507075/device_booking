import 'package:flutter/material.dart';

class Yess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.star), onPressed: () {}),
          title: Text("Confirmation"),
          backgroundColor: Colors.blue,
        ),
        body: Center(child: Text("Y E S D O W")));
  }
}
