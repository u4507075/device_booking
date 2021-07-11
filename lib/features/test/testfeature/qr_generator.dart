import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatefulWidget {
  const QrGenerator({Key? key}) : super(key: key);

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImage(
              data: "1234567890",
              version: QrVersions.auto,
              size: 200.0,
            ),
            Text('data'),
            ElevatedButton(
              onPressed: () async {},
              child: Text('refresh'),
            )
          ],
        ),
      ),
    );
  }
}
