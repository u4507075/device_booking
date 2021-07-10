import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryPlusTest extends StatefulWidget {
  // const BatteryPlusTest({Key? key}) : super(key: key);

  @override
  _BatteryPlusTestState createState() => _BatteryPlusTestState();
}

class _BatteryPlusTestState extends State<BatteryPlusTest> {
  StreamSubscription? subscription;
  String batteryState = '';

  @override
  initState() {
    super.initState();

    subscription = Battery().onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        batteryState = state.toString();
        print('Connection status changed!: ${state.toString()}');
      });
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();

    subscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Plus Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamBuilder(builder: (context, snapshot) {
              return Text('${snapshot.data}');
            }),
            FutureBuilder(
                future: Battery().batteryLevel,
                builder: (context, snapshot) {
                  return Text('${snapshot.data}');
                }),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Refresh'))
          ],
        ),
      ),
    );
  }
}
