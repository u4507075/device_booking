import 'package:device_booking/Confirmation/No.dart';
import 'package:device_booking/Confirmation/Yes.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/models/pages.dart';
import 'Back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//final Color darkBlue = Color.fromARGB(255, 13, 2, 78);

class ConfiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfiPageState();
  }
}

class _ConfiPageState extends State<ConfiPage> {

  ConfirmBook confibook = ConfirmBook();
  StreamController<String> _controller = StreamController.broadcast();

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
    var appBar= AppBar();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Backward()),
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
              width: (MediaQuery.of(context).size.width)/2.5,
              height: (MediaQuery.of(context).size.width)/2.5,
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
        SizedBox(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height)/30,
            ),
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
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 3.0),
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
                              'N A M E', style: GoogleFonts.kanit(
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
                        padding: const EdgeInsets.fromLTRB(30.0, 1.0, 14.0, 3.0),
                        child:  StreamBuilder<Object>(
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
                              '##########', style: GoogleFonts.kanit(
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
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 14.0, 8.0),
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
                              '12.00', style: GoogleFonts.kanit(
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
                  child: Text(
                    "อายุรกรรมชาย 1",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.kanit(
                      fontSize: 20.0,
                    ),),
                ),],),),
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
                            ///
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
                                            fontWeight: FontWeight.bold, color: Colors.black),
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
                          ///
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
}


/////ALERT DIALOG PART

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pop(); // dismisses only the dialog and returns nothing
      }
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Yess()),
      );
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

/*
class ConfiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appBar= AppBar();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Backward()),
              );
            }),
        title: Text("Confirmation"),
        backgroundColor: Colors.blue,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          //padding: const EdgeInsets.all(20.0),
          //color: Colors.white,//yellow,
          height: (MediaQuery.of(context).size.height - appBar.preferredSize.height),
          width: MediaQuery.of(context).size.width -appBar.preferredSize.height ,
          child: Align(
            alignment: Alignment.center,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: const EdgeInsets.all(20.0),
                      color: Colors.lightBlueAccent,
                      width: (MediaQuery.of(context).size.width)/2,
                      height: (MediaQuery.of(context).size.width)/2,
                      child: Image.network('https://picsum.photos/250?image=9')),
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      //color: Colors.white
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'ยืมโดย',
                        style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,),
                      )),
                  Row(
                      children:[
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width)/5,
                            color: Colors.blueGrey,//black12,
                            alignment: Alignment.center,
                            child: Text(
                              'User:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width -appBar.preferredSize.height)-(MediaQuery.of(context).size.width)/5,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: Text(
                              'NAME',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                      ]),
                  Row(
                      children:[
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width)/5,
                            color: Colors.blueGrey,//black12,
                            alignment: Alignment.center,
                            child: Text(
                              'Tel:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width -appBar.preferredSize.height)-(MediaQuery.of(context).size.width)/5,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: Text(
                              'NUMBER',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                      ]),
                  Row(
                      children:[
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width)/5,
                            color: Colors.blueGrey,//black12,
                            alignment: Alignment.center,
                            child: Text(
                              'Time:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width -appBar.preferredSize.height)-(MediaQuery.of(context).size.width)/5,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: Text(
                              'XX:XX',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                      ]),
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      // color: Colors.white,
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'ยืมไปใช้ที่',
                        style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,),
                      )),
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.black12, //blueGrey,
                      alignment: Alignment.center,
                      child: Text(
                        'สถานที่',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    //padding: const EdgeInsets.all(10.0),
                    //color: Colors.white,//purpleAccent,
                      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height)/5,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              padding: const EdgeInsets.all(8.0),
                              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height)/6,
                              width: (MediaQuery.of(context).size.width -appBar.preferredSize.height)/1.5,
                              //  color: Colors.white,//brown,
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Column(children: [
                                    Container(
                                        padding: const EdgeInsets.all(8.0),
                                        //width: 190,
                                        //     color: Colors.white,//orange,
                                        child: Center(
                                            child: Text(
                                              "ต้องการยืนยันหรือไม่ ?",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,),
                                            ))),
                                    Container(
                                      //padding: const EdgeInsets.all(10.0),
                                      //width: 220,
                                      //      color: Colors.white,//pinkAccent,
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  //width: 75,
                                                  //height: 40,
                                                    child: ElevatedButton(
                                                        child: Text("Yes",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16)),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                              Colors.green),
                                                        ),
                                                        onPressed: () => {showAlertDialog(context)}
                                                    )),
                                                SizedBox(
                                                  //width: 75,
                                                  //height: 40,
                                                    child: ElevatedButton(
                                                        child: Text("No",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16)),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                              .redAccent),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => Noo()),
                                                          );
                                                        })),
                                              ],
                                            )))
                                  ])))))
                ]),
          ),
        ),
      ),
    );
  }
}
*/

