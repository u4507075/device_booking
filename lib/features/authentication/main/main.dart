import 'dart:ui';
import './widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/location_hug.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Medical Device\nTracking System',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "\"Medical Device At Your Fingertip\"",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // LogInWithGoogleButton(),
                  // SizedBox(height: 20.0),
                  LogInWithPhoneButton(),
                  // signInAnonymousButton(),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'since 2021',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget authenticateDisplay(){
//   return
// }
