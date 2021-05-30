import 'dart:ui';
import 'package:device_booking/pages/loading.dart';
import 'package:device_booking/services/auth.dart';
import 'package:device_booking/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/models/user.dart';

// class Authenticate extends StatefulWidget {
//   @override
//   _AuthenticateState createState() => _AuthenticateState();
// }

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF02589D),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Medical Device Tracking System',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                height: 50.0,
              ),
              LogInWithGoogleButton(),
              SizedBox(height: 20.0),
              LogInWithPhoneButton(),
            ]),
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
      ),
    );
  }
}

class LogInWithPhoneButton extends StatelessWidget {
  const LogInWithPhoneButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 3.0,
        child: ListTile(
          onTap: () {},
          // TODO Apple free developer license can't perform login with phone number, Ref: https://help.apple.com/developer-account/#/dev21218dfd6
          leading: Icon(
            Icons.phone,
            color: Color(0xFF02589D),
            size: 40.0,
          ),
          title: Text('Continue with\nPhone number',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
        ),
      ),
    );
  }
}

class LogInWithGoogleButton extends StatelessWidget {
  const LogInWithGoogleButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserData>(context);
    return SizedBox(
      width: 300.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 3.0,
        child: ListTile(
          onTap: () async {
            await AuthService().signOut();
            Get.toNamed('/loading');
            await AuthService().signInWithGoogle().then((user) {
              user.phoneNumber.length < 10 //Incomplete signup
                  ? Get.offAndToNamed('/signup')
                  : Get.back();
            });
          },
          leading: Icon(
            Icons.login_outlined,
            color: Color(0xFF02589D),
            size: 40.0,
          ),
          title: Text('Continue with Gmail \nelearning.cmu.ac.th',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
        ),
      ),
    );
  }
}

//TODO need to add login with apple id later as required by Apple to be allowed to login with other email
