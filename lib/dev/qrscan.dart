import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:async';
import 'package:device_booking/models/pages.dart';

//Method to get permission to use qr code in ios 10.0 and beyond
//https://stackoverflow.com/questions/39465687/nscamerausagedescription-in-ios-10-0-runtime-crash

//สร้างหัวข้อ+ธีม
/*class QR_reader extends StatelessWidget {
  static final String title = 'QR Code Scanner';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.teal,
        ),
        home: MainPage(title: title),
      );
}*/
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

                        return ButtonWidget(
                        text: ScAn.Scan,
                        onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => QRScan())));
                        } else {
                          return ButtonWidget(
                              text: "Scan QR Code",
                              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => QRScan())));
                        }
                        }
                        ),
                      ]),
                    )
              );



}

// StreamBuilder<Object>(
// stream: _controller.stream,
// builder: (context, snapshot) {
//   return ButtonWidget(
//   text: ScAn.Scan,
//   onClicked: () => Navigator.of(context).push(MaterialPageRoute(
// builder: (BuildContext context) => QRScan(), //redirect
// )),
// ),
// }
// )



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

                      return ButtonWidget(
                          text: ScAn.Start,
                          onClicked: () => scanQRCode());
                    } else {
                      return ButtonWidget(
                          text: "Start QR Scan",
                          onClicked: () => scanQRCode());
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

                      return ButtonWidget(
                          text: ScAn.Copy,
                          onClicked: () {FlutterClipboard.copy("$qrCode").then((value) => print("copied"));});
                    } else {
                      return ButtonWidget(
                          text: "Copy Details",
                          onClicked: () {FlutterClipboard.copy("$qrCode").then((value) => print("copied"));});
                    }
                  }
              ),
              // ButtonWidget(
              //     text: 'Copy details',    //สร้างปุ่ม+copy to clipboard
              //     onClicked: () {
              //       FlutterClipboard.copy('$qrCode')
              //           .then((value) => print('copied'));
              //     }),
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


//buttonwidget
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    @required this.text,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
    shape: StadiumBorder(),
    color: Theme.of(context).primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textColor: Colors.white,
    onPressed: onClicked,
  );
}
