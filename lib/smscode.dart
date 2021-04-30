import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_booking/pin.dart';
import 'package:device_booking/backhome.dart';

class SMScode extends StatelessWidget {
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
              Text('Enter SMS code.',style: TextStyle(fontSize: 20)),
              Padding(
                  padding:
                  EdgeInsets.only(top: 20.0, bottom: 20.0, left: 50, right: 50),
                  child: PINcode().genTextFields(context,6, 50.0, 35.0)),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0)))),
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50, right: 50),
                  child: Text("Send", style: TextStyle(fontSize: 30)),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: BackHome(),
    );
  }
}