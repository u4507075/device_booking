import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_booking/models/pages.dart';



//final Color darkBlue = Color.fromARGB(255, 13, 2, 78);

class MyTest extends StatefulWidget {

  String email;
  String firstname;
  String imagePath;
  String lastname;
  String role;
  String telephone;
  MyTest({Key key, this.email, this.firstname, this.imagePath, this.lastname, this.role, this.telephone}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyTestState(email:email);
  }
}

class MyTestState extends State<MyTest> {

  String email;
  String firstname;
  String imagePath;
  String lastname;
  String role;
  String telephone;
  MyTestState({this.email, this.firstname, this.imagePath, this.lastname, this.role, this.telephone});

  BusyDevice busy = BusyDevice();
  StreamController<String> _controller = StreamController.broadcast();
  @override
  void initState() {
    super.initState();
    busy.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(email);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          title: StreamBuilder<Object>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data == "success") {
                  return Text(busy.Header,style: TextStyle(fontSize: 25.0,
                    fontWeight: FontWeight.bold,));
                }
                else {
                  return Text(
                    'Busy Device',
                    style: TextStyle(
                        fontSize: 35.0, fontWeight: FontWeight.bold),
                  );
                }})),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 12.0),
              child: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      return Image.network(busy.Picture);
                    }
                    else {
                      return Image(
                        image: AssetImage('assets/images/ekg_instrument.jpg'),
                      );
                    }}),),
            Card(
              margin: EdgeInsets.fromLTRB(30.0, 15.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[StreamBuilder<Object>(
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      if (snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data == "success") {
                        return Text(busy.Subheader_1,style: GoogleFonts.kanit(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),);
                      }
                      else {
                        return Text(
                          'ผู้ใช้งานปัจจุบัน',
                          style: GoogleFonts.kanit(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }}),
                ],
              ),
            ),
            Card(
              color: Colors.grey[200],
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
                          child: StreamBuilder<Object>(
                              stream: _controller.stream,
                              builder: (context, snapshot) {
                                if (snapshot != null &&
                                    snapshot.hasData &&
                                    snapshot.data == "success") {
                                  return Text(busy.Text_1,style: GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),);
                                }
                                else {
                                  return Text(
                                    "User",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }}),
                        ),
                      ),
                      Container(
                          color: Colors.grey[200],
                          margin: EdgeInsets.fromLTRB(40.0, 10.0, 16.0, 3.0),
                          child: Text(
                              'ปี 1 ศิวกร ชาญชโลธร', style: GoogleFonts.kanit(
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
                        child: StreamBuilder<Object>(
                            stream: _controller.stream,
                            builder: (context, snapshot) {
                              if (snapshot != null &&
                                  snapshot.hasData &&
                                  snapshot.data == "success") {
                                return Text(busy.Text_2,style: GoogleFonts.ubuntu(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),);
                              }
                              else {
                                return Text(
                                  "Tel",
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }}),
                      ),
                      Container(
                          color: Colors.grey[200],
                          margin: EdgeInsets.fromLTRB(40.0, 1.0, 16.0, 3.0),
                          child: Text(
                              '0863315582', style: GoogleFonts.kanit(
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
                                return Text(busy.Text_3,style: GoogleFonts.ubuntu(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),);
                              }
                              else {
                                return Text(
                                  "Time",
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }}),
                      ),
                      Container(
                          color: Colors.grey[200],
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
              elevation: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[ StreamBuilder<Object>(
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      if (snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data == "success") {
                        return Text(busy.Subheader_2,style: GoogleFonts.kanit(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),);
                      }
                      else {
                        return Text(
                          'ยืมไปใช้งานที่',
                          style: GoogleFonts.kanit(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }}),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.grey[200],
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
              child: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(busy.Suby);
                      return Text(busy.Suby,style: GoogleFonts.kanit(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )
                      );
                    }
                    else {
                      print(3);
                      return Text(
                        'ต้องการยืนยันการยืมหรือไม่ ?',
                        style: GoogleFonts.kanit(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }}),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(135.0, 5.0, 16.0, 16.0),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return Cancelled();
                            }));
                          },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[300],side: BorderSide(color: Colors.grey)), child: StreamBuilder<Object>(
                                stream: _controller.stream,
                                builder: (context, snapshot) {
                                  if (snapshot != null &&
                                      snapshot.hasData &&
                                      snapshot.data == "success") {
                                    print(2);
                                    return Text(busy.Button_1,style: GoogleFonts.kanit(
                                        fontSize: 20.0,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold
                                    ),);
                                  }
                                  else {
                                    print(1);
                                    return Text('ยกเลิก', style: GoogleFonts.kanit(
                                      fontSize: 20.0,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,),);
                                  }}),)
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.redAccent,
                    child: SizedBox(
                        height: 50,
                        width: 100,
                        child:
                        ElevatedButton(onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return Confirmed();
                          }));
                        },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          child: StreamBuilder<Object>(
                              stream: _controller.stream,
                              builder: (context, snapshot) {
                                if (snapshot != null &&
                                    snapshot.hasData &&
                                    snapshot.data == "success") {
                                  return Text(busy.Button_2,style: GoogleFonts.kanit(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),);
                                }
                                else {
                                  return Text('ยืนยัน', style: GoogleFonts.kanit(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),);
                                }}), )
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




class Cancelled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: const Text('Cancelled', style: TextStyle(fontSize: 25.0,
          fontWeight: FontWeight.bold,
        )),
      ),);}}






class Confirmed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Confirmed', style: TextStyle(fontSize: 25.0,
          fontWeight: FontWeight.bold,
        )),
      ),);}}