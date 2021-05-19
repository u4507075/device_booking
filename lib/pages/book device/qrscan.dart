import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:async';
import 'package:device_booking/models/pages.dart';


//stateful สร้าง state สร้าง column scan qr center
class MainPageQR extends StatefulWidget {

  @override
  _MainPageQRState createState() => _MainPageQRState();
}

class _MainPageQRState extends State<MainPageQR> {

  QRScanPage ScAn = QRScanPage();
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
            children: [StreamBuilder<Object>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot != null &&
                      snapshot.hasData &&
                      snapshot.data == "success") {

                    return ElevatedButton(
                        child: Text(ScAn.Scan),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => QRScan())));
                  } else {
                    return ElevatedButton(
                        child: Text("Scan QR Code"),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => QRScan())));
                  }
                }
            ),
            ]),
      )
  );
}

//หน้า qr มี ค่าอ่านได้ กับปุ่มสแกน
class QRScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanState();
}

//กำหนดค่าแรกเริ่มให้แสดงเป็น Unknown
class _QRScanState extends State<QRScan> {

  String qrCode = 'Unknown';

  QRScanPage ScAn = QRScanPage();
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
              }
          ),

          SizedBox(height: 72),
          StreamBuilder<Object>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data == "success") {

                  return ElevatedButton(
                      child: Text(ScAn.Copy),
                      onPressed: () {FlutterClipboard.copy("$qrCode").then((value) => print("copied"));});
                } else {
                  return ElevatedButton(
                      child: Text("Copy Details"),
                      onPressed: () {FlutterClipboard.copy("$qrCode").then((value) => print("copied"));});
                }
              }
          ),
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

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}