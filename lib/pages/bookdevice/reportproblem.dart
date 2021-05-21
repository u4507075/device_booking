import 'package:device_booking/models/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:math';


class ReportProblem extends StatefulWidget {
  String DeviceID;
  ReportProblem({Key key, this.DeviceID}) : super(key: key);

  @override
  _ReportProblemState createState() {
    return _ReportProblemState(DeviceID:DeviceID);
  }
}

class _ReportProblemState extends State<ReportProblem> {
  ReportProblemPage Reportproblem = ReportProblemPage();
  StreamController<String> _controller = StreamController.broadcast();
  String DeviceID;
  _ReportProblemState({this.DeviceID});
  @override
  void initState() {
    super.initState();
    Reportproblem.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            elevation:0,
            title: StreamBuilder<Object>(
                stream: _controller.stream,
                builder: (context, snapshot)
                {
                  if (snapshot != null &&
                      snapshot.hasData &&
                      snapshot.data == "success") {
                    print(snapshot);
                    print(snapshot.data);
                    print(Reportproblem.Header);
                    return Text(
                      Reportproblem.Header,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return Text(
                      'loading /ja',
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold),
                    );
                  }
                }
            )
        ),
          body: MyCustomForm(DeviceID:DeviceID),
        )
    );
  }
}
class MyCustomForm extends StatefulWidget {
  String DeviceID;
  MyCustomForm({Key key, this.DeviceID}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(DeviceID:DeviceID);
  }
}

class MyCustomFormState extends State<MyCustomForm> {

  String DeviceID;
  MyCustomFormState({this.DeviceID});

  ReportProblemPage Reportproblem = ReportProblemPage();

  TextEditingController TextFieldController = new TextEditingController();

  StreamController<String> _controller = StreamController.broadcast();

  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    Reportproblem.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(20.0),
      child:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: TextFieldController,
              keyboardType: TextInputType.multiline,
              minLines: 10,
              maxLines: 30,
              decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter here',
              ),
            ),
            StreamBuilder<Object>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot != null &&
                      snapshot.hasData &&
                      snapshot.data == "success") {

                    return ElevatedButton(
                        child: Text(Reportproblem.Submit),
                        onPressed: () {
                          if (TextFieldController.text == '') {
                            Navigator.of(context, rootNavigator: true).pop(context);
                          }else{
                            Navigator.of(context, rootNavigator: true).pop(context);
                            updateData();
                          }
                        }
                    );
                  }
                  else {
                    return ElevatedButton(
                        child: Text('submit'),
                        onPressed: () {
                          if (TextFieldController.text == '') {
                            Navigator.of(context, rootNavigator: true).pop(context);
                          }else{
                            Navigator.of(context, rootNavigator: true).pop(context);
                            updateData();
                          }
                        }
                    );
                  }
                }
            ),
          ],

        ),
      ),
      alignment: Alignment.center,
    );
  }
  void updateData() {
    String time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    String documentID = (getRandomString(20));
    try {
      databaseReference.collection('devices')
          .doc(DeviceID)
          .collection('deviceProblems')
          .doc('$documentID')
          .set({'datetime': "$time" , 'problem' : TextFieldController.text , 'uid' : 'UserID'});
    } catch (e) {
      print(e.toString());
    }
  }

}