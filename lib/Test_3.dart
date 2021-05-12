import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_booking/Test_4.dart';
import 'package:device_booking/Test_5.dart';

//final Color darkBlue = Color.fromARGB(255, 13, 2, 78);

class MyTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTestState();
  }
}

class MyTestState extends State<MyTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          title: const Text('Busy Device', style: TextStyle(fontSize: 25.0,
            fontWeight: FontWeight.bold,
          )),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 0.0),
                child: Image(
                image: AssetImage('assets/images/ekg_instrument.jpg'),
              ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Cancelled();
                  }));
                },
                  style: ElevatedButton.styleFrom(
                  primary: Colors.grey[200],side: BorderSide(color: Colors.grey)), child: Text('ยกเลิก', style: GoogleFonts.kanit(
                fontSize: 20.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,),),)
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
                        child: Text('ยืนยัน', style: GoogleFonts.kanit(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,),),)
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

