import 'dart:ui';
import 'package:device_booking/services/auth.dart';
import 'package:device_booking/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/models/user.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // Future<void> signIn() async {
  //   return AuthService().signInWithGoogle().then((user) {
  //     if (user.uid != null) {
  //       //login success -> navigate to 'Home' with user data
  //       Navigator.pushReplacementNamed(context, '/signup',
  //           arguments: {'user': user});
  //       print('log in success');
  //     } else {
  //       //login failed -> reload 'Auth'
  //       Navigator.pushReplacementNamed(context, '/authenticate');
  //       print('log in failed');
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              SizedBox(
                width: 300.0,
                child: Card(
                  margin: EdgeInsets.all(5.0),
                  elevation: 3.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/loading');
                      AuthService().signInWithGoogle().then((user) {
                        if (user == null) {
                          Navigator.pop(context);
                          print('Log in unsuccessful');
                        } else {
                          //Log in success
                          DBService().checkUser(user.uid).then((hasData) {
                            //check previous data
                            if (hasData) {
                              //check complete data
                              DBService().getUser(user.uid).then((userData) {
                                Navigator.popUntil(
                                    context,
                                    ModalRoute.withName(
                                        Navigator.defaultRouteName));
                                if (userData.firstname.length < 2 ||
                                    userData.lastname.length < 2 ||
                                    userData.phoneNumber.length < 10 ||
                                    userData.role == null) {
                                  Navigator.pushNamed(context, '/signup');
                                }
                              });
                            }
                          });
                        }
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
              ),
              SizedBox(height: 20.0),
              SizedBox(
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
              ),
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

//TODO need to add login with apple id later as required by Apple to be allowed to login with other email
