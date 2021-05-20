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
import 'package:device_booking/pages/bookdevice/busy_device.dart';
import 'package:device_booking/pages/bookdevice/Select_location.dart';
import 'package:device_booking/pages/loading.dart';

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
  String BorrowTime;
  String BorrowPlace;

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
      Navigator.pushNamed(context,"/loading");
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
      }));
      FirebaseDB().fetchDeviceStatus(qrCode).then((status) {  setState(() {
        this.qrCode = qrCode;
        this.devicestatus = status;
        this.ID = status.userid;
        this.BorrowTime = status.timestamp;
        this.BorrowPlace = status.BorrowPlace;
      });
      FirebaseDB().fetchUserDetails(ID).then((userr) => setState(() {
        this.userdetails = userr;
        email = userr.email;
        firstname = userr.firstname;
        imagePath = userr.imagePath;
        lastname = userr.lastname;
        role = userr.role;
        telephone = userr.telephone;
        Navigator.pop(context);
        if (status.status == "borrowed") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>MyTest(BorrowPlace:BorrowPlace , BorrowTime:BorrowTime , email:email , firstname:firstname , imagePath:imagePath , lastname:lastname , role:role , telephone:telephone)));
        }else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>LocationList()));
        }
      }));});
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
