import 'package:flutter/material.dart';
import 'package:device_booking/getotp.dart';
import 'package:device_booking/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/book.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 100.0, bottom: 0.0, left: 50, right: 50),
            child: Image.network('https://device-tracking-system.obs.ap-southeast-2.myhuaweicloud.com/img/device.png'),),
          Expanded(
              child: Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('Suandok Device Tracking System',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,

                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))))),
          Container(
            margin: const EdgeInsets.only(bottom: 25.0),
            child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0)
                          )
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50, right: 50),
                    child: Text("Gmail Login",
                        style: TextStyle(fontSize: 30)),),
                  onPressed: () async {
                    await signInWithGoogle()
                        .then((UserCredential user) {
                        if (user != null){
                          Navigator.push(context, MaterialPageRoute(builder: (_) {return Book(user.user.email);}));
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (_) {return Home();}));
                        }
                        }
                        )
                        .catchError((e) => print(e));
                  },
                )),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 220.0),

            child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0)
                          )
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50, right: 50),
                    child: Text("Phone Login",
                        style: TextStyle(fontSize: 30)),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return GetOTP();
                    }));
                  },
                )),
          )
        ],
      ),
    );
  }
}