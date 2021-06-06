import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';
import 'dart:io';
import 'database.dart';

class Load extends StatefulWidget {
  LoadState createState() => LoadState();
}

class LoadState extends State<Load> {
  StreamController<String> _controller = StreamController();
  @override
  void initState() {
    super.initState();
    _controller.add('Loading');
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    getID(context);
    return Scaffold(
      // Column is a vertical, linear layout.
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: StreamBuilder<String>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data);
                    } else {
                      return Text("Loading");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void getID(BuildContext context) async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      // unique ID on iOS
      _controller.add(iosDeviceInfo.identifierForVendor);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Info(iosDeviceInfo.identifierForVendor);
      }));
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // unique ID on Android
      _controller.add(androidDeviceInfo.androidId);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Info(androidDeviceInfo.androidId);
      }));
    }
  }
}
