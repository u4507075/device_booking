//import 'dart:html';
import 'dart:async';
import 'dart:ui';
import 'package:device_booking/models/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/models/pages.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

// void main() {
//   runApp(MyApp2());
// }

// class MyApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.white),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: MyWidget(),
//         ),
//       ),
//     );
//   }
// }

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  LogInPageModel login = LogInPageModel();
  String header;
  StreamController<String> _controller = StreamController();

  @override
  void initState() {
    super.initState();
    login.fetchAll(_controller);
  }

  // login.fetchAll().then((value) {
  // this.header = login.getHeader();
  // _controller.add(login.getHeader());

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
                        initialData: 'Hi',
                        builder: (context, snapshot) {
                          return Text(
                            login.header,
                          );
                          // print(snapshot);

                          // if (snapshot != null &&
                          //     snapshot.hasData &&
                          //     snapshot.data == "success") {
                          //   print(snapshot.data);
                          //   return Text(
                          //     login.header,
                          //     style: TextStyle(
                          //         fontSize: 35.0, fontWeight: FontWeight.bold),
                          //   );
                          // } else {
                          //   return Text(
                          //     'Medical Device Tracking System',
                          //     style: TextStyle(
                          //         fontSize: 35.0, fontWeight: FontWeight.bold),
                          //   );
                          // }
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

// class MyWidget extends StatelessWidget {

//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
