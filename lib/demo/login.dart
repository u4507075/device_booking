import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_booking/demo/getotp.dart';
import 'package:device_booking/demo/book.dart';

class Login extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  StreamController<String> _controller = StreamController();
  @override
  void initState() {
    super.initState();
    _controller.add('Loading');
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
    Future.delayed(Duration.zero, () async {
      checkID(context);
    });

    return Scaffold(
      // Column is a vertical, linear layout.
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: StreamBuilder<String>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data);
                    } else {
                      return Text("Loading");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void checkID(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    print(user);
    if (user == null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return GetOTP();
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Book(user.phoneNumber);
      }));
    }
  }
}
