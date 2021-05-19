import 'package:flutter/material.dart';

class ScanQrCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.grey[100],
      label: Text(
        'ยืมอุปกรณ์',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      icon: Icon(Icons.qr_code_scanner_outlined),
      onPressed: () {},
    );
  }
}
