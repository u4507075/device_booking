import 'home.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'smscode.dart';
import 'pin.dart';
import 'backhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'book.dart';
import 'alert.dart';

class GetOTP extends StatefulWidget {
  GetOTPState createState() => GetOTPState();
}

class GetOTPState extends State<GetOTP> {
  PINcode pincode = PINcode();
  StreamController<bool> _controller = StreamController();
  @override
  void initState() {
    super.initState();
    _controller.add(false);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
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
            Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 50.0, bottom: 50.0, left: 0, right: 0),
                child: pincode.genTextFields(context, _controller, 10, 30.0,
                    25.0)), // end PinEntryTextField()),
            StreamBuilder<bool>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  return ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(28.0)))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 50, right: 50),
                      child: Text("Get OTP", style: TextStyle(fontSize: 30)),
                    ),
                    onPressed: snapshot.hasData && snapshot.data == false
                        ? null
                        : () {
                            _controller.add(false);
                            sendRequest(context);
                          },
                  );
                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: BackHome(),
    );
  }

  void sendRequest(BuildContext context) {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.verifyPhoneNumber(
        phoneNumber: "+66" + pincode.getValues(),
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Book(pincode.getValues());
          }));
        },
        verificationFailed: (FirebaseAuthException e) {
          Alert().show(context, e.code);
        },
        codeSent: (String verificationId, int resendToken) {
          //Use sms code in IOS and Huawei
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return SMScode(verificationId, pincode.getValues());
          }));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return SMScode(verificationId, pincode.getValues());
          }));
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
