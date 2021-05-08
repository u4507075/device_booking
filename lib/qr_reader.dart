import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(QR_reader());
}

class QR_reader extends StatelessWidget {
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
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            text: 'Scan QR Code',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => QRScanPage(),
            )),
          ),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

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

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String qrCode = 'Unknown';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(QR_reader.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Scan Result',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$qrCode',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 72),
          ButtonWidget(
            text: 'Start QR scan',
            onClicked: () => scanQRCode(),
          ),
          SizedBox(height: 72),
          ButtonWidget(
              text: 'Copy details',
              onClicked: () {
                FlutterClipboard.copy('$qrCode').then(( value ) => print('copied'));
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
