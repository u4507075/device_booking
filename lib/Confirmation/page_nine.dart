import 'package:device_booking/Confirmation/No.dart';
import 'package:device_booking/Confirmation/Yes.dart';
import 'package:flutter/material.dart';
import 'Back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//final Color darkBlue = Color.fromARGB(255, 13, 2, 78);

class ConfiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfiPageState();
  }
}

class ConfiPageState extends State<ConfiPage> {
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
        title: const Text('Confirmation', style: TextStyle(fontSize: 25.0,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
              width: (MediaQuery.of(context).size.width)/3,
              height: (MediaQuery.of(context).size.width)/3,
              child: Image.network(
                  'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.6435-9/184880727_4162080337208955_872074179837376358_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=730e14&_nc_eui2=AeFzMXV3_6_c_5A3U4oH_xN_mJBlnkPjqVCYkGWeQ-OpUE_RIzwoH0Cw60DcWaY2sb1aPDxoXxpM5gEwDvLcG_2A&_nc_ohc=QRfxHEdguFgAX-bXfXz&_nc_ht=scontent.fcnx4-1.fna&oh=bf92e661f2eafb8993210e705f1de133&oe=60BF59AF'),
              ),
            SizedBox(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height)/28,
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30.0, 15.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'ผู้ใช้งานปัจจุบัน',
                    style: GoogleFonts.kanit(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),],
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
                          child: Text(
                            "User",
                            style: GoogleFonts.ubuntu(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                        child: Text(
                          "Tel",
                          style: GoogleFonts.ubuntu(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
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
                        child: Text(
                          "Time",
                          style: GoogleFonts.ubuntu(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                children: <Widget>[ Text(
                  'ยืมไปใช้งานที่',
                  style: GoogleFonts.kanit(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              child: Text(
                'ต้องการยืนยันการยืมหรือไม่ ?',
                style: GoogleFonts.kanit(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(120.0, 0.0, 16.0, 16.0),
              color: Colors.white,
              child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.blue,
                    child: SizedBox(
                        height: 50,
                        child:
                        ElevatedButton(onPressed: () => {showAlertDialog(context)},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue),
                          child: Text('Confirm', style: GoogleFonts.kanit(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,),),)
                    ),
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

