import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';
import 'dart:io';
import 'package:device_booking/demo/book.dart';
import 'package:device_booking/demo/database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

class Status extends StatefulWidget {
  FirebaseApp app;
  String deviceId;
  Status(FirebaseApp app, String deviceId) {
    this.app = app;
    this.deviceId = deviceId;
  }
  StatusState createState() => StatusState(app, deviceId);
}

class StatusState extends State<Status> {
  FirebaseApp app;
  String deviceId;
  StatusState(FirebaseApp app, String deviceId) {
    this.app = app;
    this.deviceId = deviceId;
  }
  FirebaseDatabase database;
  StreamController<String> _controller = StreamController();
  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase(app: widget.app);
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
    final ref = database.reference();
    listenStatusChange(ref);
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
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0)))),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 50, right: 50),
                  child: Text("Send", style: TextStyle(fontSize: 30)),
                ),
                onPressed: () {
                  String v =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                  ref
                      .child(deviceId)
                      .push()
                      .set(<String, String>{"date": "spatipan $v"});
                }),
          ],
        ),
      ),
    );
  }

  void listenStatusChange(DatabaseReference ref) {
    ref.child(deviceId).limitToLast(1).onChildAdded.listen((event) {
      Map<String, dynamic> data =
      new Map<String, dynamic>.from(event.snapshot.value);
      _controller.add('Child added: ${data["date"]}');
    });
  }
}