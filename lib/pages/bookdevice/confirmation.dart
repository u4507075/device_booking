import 'package:device_booking/pages/bookdevice/Select_location.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/models/pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/pages/bookdevice/InUse.dart';

//final Color darkBlue = Color.fromARGB(255, 13, 2, 78);

class ConfiPage extends StatefulWidget {

  String Memail;
  String Mfirstname;
  String MimagePath;
  String Mlastname;
  String Mrole;
  String Mtelephone;
  String place;
  String qrCode;
  String myID;
  ConfiPage({Key key, this.myID, this.qrCode, this.place, this.Memail, this.Mfirstname, this.MimagePath, this.Mlastname, this.Mrole, this.Mtelephone}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConfiPageState(myID:myID , qrCode:qrCode , place:place , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone);
  }
}

class _ConfiPageState extends State<ConfiPage> {

  ConfirmBook confibook = ConfirmBook();
  StreamController<String> _controller = StreamController.broadcast();

  String Memail;
  String Mfirstname;
  String MimagePath;
  String Mlastname;
  String Mrole;
  String Mtelephone;
  String place;
  String time;
  String qrCode;
  String myID;

  _ConfiPageState(
      {this.myID, this.qrCode, this.place, this.Memail, this.Mfirstname, this.MimagePath, this.Mlastname, this.Mrole, this.Mtelephone});

  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    confibook.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LocationList()),
              );
            }),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: StreamBuilder<Object>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.hasData &&
                  snapshot.data == "success") {
                return Text(
                  confibook.header,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,),
                );
              } else {
                return Text(
                  'Confirmation',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,),
                );
              }
            }),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
              width: (MediaQuery
                  .of(context)
                  .size
                  .width) / 3,
              height: (MediaQuery
                  .of(context)
                  .size
                  .width) / 3,
              child: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      return Image.network(confibook.picture);
                    } else {
                      return Text(
                        'Confirmation',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,),
                      );
                    }
                  }),),
            Card(
              margin: EdgeInsets.fromLTRB(30.0, 15.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StreamBuilder<Object>(
                      stream: _controller.stream,
                      builder: (context, snapshot) {
                        if (snapshot != null &&
                            snapshot.hasData &&
                            snapshot.data == "success") {
                          return Text(
                            confibook.subheader_1,
                            style:
                            GoogleFonts.kanit(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,),
                          );
                        } else {
                          return Text(
                            'Confirmation',
                            style: GoogleFonts.kanit(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,),
                          );
                        }
                      }),
                ],
              ),
            ),
            Card(
              color: Colors.grey[300],
              margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            30.0, 10.0, 0.0, 3.0),
                        child: SizedBox(
                          height: 25,
                          child:
                          StreamBuilder<Object>(
                              stream: _controller.stream,
                              builder: (context, snapshot) {
                                if (snapshot != null &&
                                    snapshot.hasData &&
                                    snapshot.data == "success") {
                                  return Text(
                                    confibook.text_1,
                                    style:
                                    GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,),
                                  );
                                } else {
                                  return Text(
                                    'User',
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,),
                                  );
                                }
                              }),
                        ),
                      ),
                      Container(
                          color: Colors.grey[300],
                          margin: EdgeInsets.fromLTRB(40.0, 10.0, 16.0, 3.0),
                          child: Text(
                              Mrole + ' ' + ' ' + Mfirstname + ' ' + ' ' +
                                  Mlastname, style: GoogleFonts.kanit(
                            fontSize: 20.0,
                          )
                          )
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            30.0, 1.0, 14.0, 3.0),
                        child: StreamBuilder<Object>(
                            stream: _controller.stream,
                            builder: (context, snapshot) {
                              if (snapshot != null &&
                                  snapshot.hasData &&
                                  snapshot.data == "success") {
                                return Text(
                                  confibook.text_2,
                                  style:
                                  GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,),
                                );
                              } else {
                                return Text(
                                  'Tel',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,),
                                );
                              }
                            }),
                      ),
                      Container(
                          color: Colors.grey[300],
                          margin: EdgeInsets.fromLTRB(40.0, 1.0, 16.0, 3.0),
                          child: Text(
                              Mtelephone, style: GoogleFonts.kanit(
                            fontSize: 20.0,
                          )
                          )
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            30.0, 0.0, 14.0, 8.0),
                        child: StreamBuilder<Object>(
                            stream: _controller.stream,
                            builder: (context, snapshot) {
                              if (snapshot != null &&
                                  snapshot.hasData &&
                                  snapshot.data == "success") {
                                return Text(
                                  confibook.text_3,
                                  style:
                                  GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,),
                                );
                              } else {
                                return Text(
                                  'Time',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,),
                                );
                              }
                            }),
                      ),
                      Container(
                          color: Colors.grey[300],
                          margin: EdgeInsets.fromLTRB(22.0, 0.0, 16.0, 8.0),
                          child: Text(
                              time, style: GoogleFonts.kanit(
                            fontSize: 20.0,
                          )
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30.0, 10.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StreamBuilder<Object>(
                      stream: _controller.stream,
                      builder: (context, snapshot) {
                        if (snapshot != null &&
                            snapshot.hasData &&
                            snapshot.data == "success") {
                          return Text(
                            confibook.subheader_2,
                            style:
                            GoogleFonts.kanit(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,),
                          );
                        } else {
                          return Text(
                            'ยืมไปใช้งานที่',
                            style: GoogleFonts.kanit(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,),
                          );
                        }
                      }),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[ Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(place,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.kanit(
                      fontSize: 20.0,
                    ),),
                ),
                ],),),
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(120.0, 0.0, 16.0, 5.0),
              child:
              StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      return Text(
                        confibook.subheader_3,
                        style:
                        GoogleFonts.kanit(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,),
                      );
                    } else {
                      return Text(
                        'ต้องการยืนยันการยืมหรือไม่ ?',
                        style: GoogleFonts.kanit(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,),
                      );
                    }
                  }),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(140.0, 5.0, 16.0, 16.0),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 1.0, 14.0, 3.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationList()),
                            );
                          },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[200],
                                side: BorderSide(color: Colors.grey)),
                            child: StreamBuilder<Object>(
                                stream: _controller.stream,
                                builder: (context, snapshot) {
                                  if (snapshot != null &&
                                      snapshot.hasData &&
                                      snapshot.data == "success") {
                                    return Text(
                                      confibook.button_1,
                                      style:
                                      GoogleFonts.kanit(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    );
                                  } else {
                                    return Text(
                                      'แก้้ไข',
                                      style: GoogleFonts.kanit(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,),
                                    );
                                  }
                                }),)
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    //color: Colors.redAccent,
                    child: SizedBox(
                        height: 50,
                        width: 100,
                        child:
                        ElevatedButton(onPressed: () {
                          showAlertDialog(context);
                        },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue),
                          child: StreamBuilder<Object>(
                              stream: _controller.stream,
                              builder: (context, snapshot) {
                                if (snapshot != null &&
                                    snapshot.hasData &&
                                    snapshot.data == "success") {
                                  return Text(
                                    confibook.button_2,
                                    style:
                                    GoogleFonts.kanit(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,),
                                  );
                                } else {
                                  return Text(
                                    'ยืนยัน',
                                    style: GoogleFonts.kanit(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,),
                                  );
                                }
                              }),)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void CreateLog() {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    String documentID = (getRandomString(20));
    try {
      databaseReference.collection('devices')
          .doc(qrCode)
          .collection('log')
          .doc('$documentID')
          .set({
        'Location': "$place",
        'User': '$Mrole + $Mfirstname + $Mlastname',
        'time': '$time'
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateLastest() {
    try {
      databaseReference.collection('device_status')
          .doc(qrCode)
          .update({'BorrowPlace': place , 'status':'busy' , 'timestamp':time , 'userid':myID});
    } catch (e) {
      print(e.toString());
    }}

/////ALERT DIALOG PART
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .pop(); // dismisses only the dialog and returns nothing
        }
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>Placeholder()));
        CreateLog();
        updateLastest();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) {
          return MainPageBusy();
        }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('AlertDialog'),
      content: Text('Would you like to borrow "Device"'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}