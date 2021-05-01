import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_booking/pin.dart';
import 'package:device_booking/backhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/home.dart';
import 'package:device_booking/book.dart';
import 'package:device_booking/alert.dart';
import 'dart:async';
import 'dart:io';

class SMScode extends StatefulWidget {
  String phone;
  String verificationId;
  SMScode(String verificationId, String phone){
    this.verificationId = verificationId;
    this.phone = phone;
  }
  SMScodeState createState() => SMScodeState(verificationId, phone);
}

class SMScodeState extends State<SMScode> {
  PINcode pincode = PINcode();
  String phone;
  String verificationId;
  StreamController<bool> _controller = StreamController();

  SMScodeState(String verificationId, String phone){
    this.verificationId = verificationId;
    this.phone = phone;
  }

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
              Text('Enter SMS code.',style: TextStyle(fontSize: 20)),
              Padding(
                  padding:
                  EdgeInsets.only(top: 20.0, bottom: 20.0, left: 50, right: 50),
                  child: pincode.genTextFields(context,_controller,6, 50.0, 35.0)),
            StreamBuilder<bool>(
            stream: _controller.stream,
            builder: (context, snapshot) {
            return ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0)))),
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50, right: 50),
                  child: Text("Send", style: TextStyle(fontSize: 30)),
                ),
                onPressed: snapshot.hasData && snapshot.data == false ? null : () {
                  _controller.add(false);
                  verifyPhone(context);
                },
              );}),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: BackHome(),
    );
  }
  verifyPhone(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: pincode.getValues());

    // Sign the user in (or link) with the credential
    auth.signInWithCredential(credential).then((user){
      print('signed in with phone number successful: user -> $user');
      Navigator.push(context, MaterialPageRoute(builder: (_) {return Book(user.user.phoneNumber);}));
    }).catchError((onError){
      Alert().show(context,"Invalid SMS code.");
    });
  }
}