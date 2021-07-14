import 'package:device_booking/core/device/device_service.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';

class ProbeLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                DeviceService().fetchProbeLocation();
              },
              child: Text('Tester 1'))),
    );
  }
}
