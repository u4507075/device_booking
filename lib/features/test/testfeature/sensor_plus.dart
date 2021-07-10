import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorPlusTest extends StatefulWidget {
  // const SensorPlusTest({Key? key}) : super(key: key);

  @override
  _SensorPlusTestState createState() => _SensorPlusTestState();
}

class _SensorPlusTestState extends State<SensorPlusTest> {
  String connectionStatus = '';

  @override
  initState() {
    super.initState();
    // accelerometerEvents.listen((AccelerometerEvent event) {
    //   // print(event);
    // });
    // userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    //   // print(event);
    // });
    // gyroscopeEvents.listen((GyroscopeEvent event) {
    //   // print(event);
    // });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Plus Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder(
              stream: accelerometerEvents,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text('${snapshot.data}');
              },
            ),
            StreamBuilder(
              stream: userAccelerometerEvents,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text('${snapshot.data}');
              },
            ),
            StreamBuilder(
              stream: gyroscopeEvents,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text('${snapshot.data}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
