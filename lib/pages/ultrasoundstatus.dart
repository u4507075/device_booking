import 'dart:ui';

import 'package:device_booking/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/src/button.dart';
import 'package:device_booking/src/qrfloatingbutton.dart';
import 'package:device_booking/pages/deviceinfo.dart';

class UltrasoundStatus extends StatelessWidget {
  final String _assetPath = "assets/images/ultrasonography.png";
  final String _title = "Ultrasound";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, size: 30.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Device Location',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Scrollbar(
              isAlwaysShown: true,
              showTrackOnHover: true,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    for (var i = 1; i < 6; i++)
                      CardStatus('$_title $i', _assetPath, 80.0, Colors.green),
                    for (var i = 6; i < 11; i++)
                      CardStatus(
                          '$_title $i', _assetPath, 80.0, Colors.red[800]),
                    for (var i = 11; i < 16; i++)
                      CardStatus('$_title $i', _assetPath, 80.0, Colors.amber),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScanQrCode(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
