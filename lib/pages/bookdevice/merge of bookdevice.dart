import 'package:device_booking/services/database.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/devicestatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:async';
import 'package:device_booking/models/pages.dart';
import 'package:device_booking/models/Userdetail.dart';
import 'package:google_fonts/google_fonts.dart';



//หน้า qr มี ค่าอ่านได้ กับปุ่มสแกน
class QRScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanState();
}

//กำหนดค่าแรกเริ่มให้แสดงเป็น Unknown
class _QRScanState extends State<QRScan> {
  String qrCode = 'Unknown';
  String ID;
  String email;
  String firstname;
  String imagePath;
  String lastname;
  String role;
  String telephone;

  Device device = Device().defaultValue();
  QRScanPage ScAn = QRScanPage();
  DeviceStatus devicestatus = DeviceStatus().defaultValue();
  UserDetails userdetails = UserDetails().defaultValue();


  StreamController<String> _controller = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    ScAn.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: StreamBuilder<Object>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if (snapshot != null &&
                snapshot.hasData &&
                snapshot.data == "success") {
              return Text(ScAn.Brrr);
            } else {
              return Text('QR Code Scanner');
            }
          }),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(device.name),
          StreamBuilder<Object>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data == "success") {
                  return Text(
                    ScAn.Result,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text(
                    'Scan Result',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              }),
          SizedBox(height: 8),
          Text(
            '$qrCode',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 72),
          StreamBuilder<Object>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data == "success") {
                  return ElevatedButton(
                      child: Text(ScAn.Start),
                      onPressed: () => scanQRCode());
                } else {
                  return ElevatedButton(
                      child: Text("Start QR Scan"),
                      onPressed: () => scanQRCode());
                }
              }),
          SizedBox(height: 72),
          StreamBuilder<Object>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data == "success") {
                  return ElevatedButton(
                      child: Text(ScAn.Copy),
                      onPressed: () {
                        FlutterClipboard.copy("$qrCode")
                            .then((value) => print("copied"));
                      });
                } else {
                  return ElevatedButton(
                      child: Text("Copy Details"),
                      onPressed: () {
                        FlutterClipboard.copy("$qrCode")
                            .then((value) => print("copied"));
                      });
                }
              }),
        ],
      ),
    ),
  );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;
      FirebaseDB().fetchDevice(qrCode).then((value) => setState(() {
        this.qrCode = qrCode;
        this.device = value;
        print(value.name);
      }));
      FirebaseDB().fetchDeviceStatus(qrCode).then((status) => setState(() {
        this.qrCode = qrCode;
        this.devicestatus = status;
        print(status.status);
        this.ID =status.userid;
        if (status.status == "borrowed") {
          Navigator.pushNamed(context, '/bookdevice/busydevice');
        }else {
          Navigator.pushNamed(context, '/bookdevice/selectLo');
        }
      }));
      FirebaseDB().fetchUserDetails(ID).then((userr) => setState(() {
        this.userdetails = userr;
        email = userr.email;
        firstname = userr.firstname;
        imagePath = userr.imagePath;
        lastname = userr.lastname;
        role = userr.role;
        telephone = userr.telephone;

      }));
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
//------------------------------------------------------------------------------------------------------------------------------------



class LocationList extends StatefulWidget {


  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  SelectLoPage selectLo = SelectLoPage();
  StreamController<String> _controller = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    selectLo.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0,
          title: StreamBuilder<Object>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data == "success") {
                  print(snapshot);
                  print(snapshot.data);
                  print(selectLo.header);
                  return Text(selectLo.header,);
                } else {
                  return Text('Loading',);
                }
              }),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item01);
                      return Text(selectLo.item01,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item01)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item02);
                      return Text(selectLo.item02,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item02)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item03);
                      return Text(selectLo.item03,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item03)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item04);
                      return Text(selectLo.item04,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item04)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item05);
                      return Text(selectLo.item05,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item05)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item06);
                      return Text(selectLo.item06,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item06)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item07);
                      return Text(selectLo.item07,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item07)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item08);
                      return Text(selectLo.item08,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item08)
                    )
                );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item09);
                      return Text(selectLo.item09,);
                    } else {
                      return Text('Loading',);
                    }
                  }),onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>ConfiPage(place:selectLo.item09)
                  )
              );},
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item10);
                      return Text(selectLo.item10,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item10)
                    )
                );},
            ),
          ],
        ),
      ),
    );
  }
}
//------------------------------------------------------------------------------------------------------------------------------------


//final Color darkBlue = Color.fromARGB(255, 13, 2, 78);

class ConfiPage extends StatefulWidget {
  String place = "";
  ConfiPage({Key key, this.place}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ConfiPageState(place:place);
  }
}

class _ConfiPageState extends State<ConfiPage> {

  ConfirmBook confibook = ConfirmBook();
  StreamController<String> _controller = StreamController.broadcast();
  String place = "";
  _ConfiPageState({this.place});

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
              width: (MediaQuery.of(context).size.width)/3,
              height: (MediaQuery.of(context).size.width)/3,
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
                  child: Text(place,
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LocationList()),
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
  Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pop(); // dismisses only the dialog and returns nothing
      }
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          ///
        }),
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
//------------------------------------------------------------------------------------------------------------------------------------
