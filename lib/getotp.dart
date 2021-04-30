import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_booking/smscode.dart';
import 'package:device_booking/pin.dart';
import 'package:device_booking/backhome.dart';

class GetOTP extends StatelessWidget {
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
              Text('Enter your phone number',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: 50.0, bottom: 50.0, left: 0, right: 0),
                child: PINcode().genTextFields(context,9, 30.0, 25.0)), // end PinEntryTextField()),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0)))),
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50, right: 50),
                  child: Text("Get OTP", style: TextStyle(fontSize: 30)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return SMScode();
                  }));
                },
              ),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: BackHome(),
    );
  }

}