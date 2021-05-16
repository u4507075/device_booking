import 'dart:async';
import 'dart:ui';
import 'package:device_booking/models/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  LogInPage login = LogInPage();
  StreamController<String> _controller = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    login.fetchAll(_controller);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: 270,
        decoration: BoxDecoration(
          color: Color(0xFF02589D),
        ),
      ),
      Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 170),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot) {
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Text(
                              login.header,
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Text(
                              'Medical Device Tracking System',
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.bold),
                            );
                          }
                        }),
                    Text(
                      "\"Medical Device At Your Fingertip\"",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                    Text("\n\n\n\n"),
                    Card(
                      elevation: 3.0,
                      color: Colors.white,
                      child: OutlinedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.login_rounded,
                                  color: Color(0xFF02589D),
                                  size: 40.0,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                    'Continue with Gmail \nelearning.cmu.ac.th',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                              ],
                            ),
                          )),
                    ),
                    Text("\n"),
                    Card(
                      elevation: 3.0,
                      color: Colors.white,
                      child: OutlinedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Color(0xFF02589D),
                                  size: 40.0,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                    'Continue with            \nphone number          ',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                              ],
                            ),
                          )),
                    ),
                  ])))
    ]));
  }
}

// print(snapshot);

// if (snapshot != null &&
//     snapshot.hasData &&
//     snapshot.data == "success") {

//   return Text(login.header,);
// } else {
//   return Text('Medical Device Tracking System',);
// }
