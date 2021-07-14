import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:device_booking/core/core.dart';

class QrGenerator extends StatefulWidget {
  const QrGenerator({Key? key}) : super(key: key);

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: generateQrCodeFile('12343123879087907890123123123'),
        builder: (context, snapshot) {
          var path = snapshot.data as String?;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (snapshot.hasData && snapshot.data != null)
                      ? Image.file(File(path!))
                      : CircularProgressIndicator(),
                  ElevatedButton(
                    onPressed: () async {
                      saveQrToGallery(';lkj;lkjasd');
                    },
                    child: Text('Save to gallery'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
