import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_booking/home.dart';

class BackHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: EdgeInsets.only(top: 20.0, right: 10),
    child: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Home();
          }));
        },
        child: const Icon(Icons.home),
        backgroundColor: Colors.blue,
      ));
    throw UnimplementedError();
  }
  
}