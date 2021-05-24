import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Info extends StatefulWidget {
  String userid;
  Info(String userid) {
    this.userid = userid;
  }
  InfoState createState() => InfoState(userid);
}

class InfoState extends State<Info> {
  String userid;
  InfoState(String userid) {
    this.userid = userid;
  }
  //final fb = FirebaseDatabase.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  StreamController<String> _controller = StreamController();
  @override
  void initState() {
    super.initState();
    _controller.add("loading");
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
                onPressed: () async {
                  users.doc(userid).set({
                    "date":
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
                  });
                  fetchData(users, userid);
                  /*
                      ref.child(userid).once().then((DataSnapshot data){
                        print(data.value);
                        print(data.key);
                        _controller.add(data.key+": "+data.value["date"]);
                      });*/
                }),
          ],
        ),
      ),
    );
  }

  void fetchData(CollectionReference users, userid) async {
    List contactList = [];
    DocumentSnapshot documentSnapshot = await users.doc(userid).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data();
      _controller.add(data["date"]);
    }
  }
}
