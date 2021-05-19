import 'package:device_booking/services/firebasedb.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/services/firebasedb.dart';


class Device {
  String deviceId;
  String type;
  String name;
  List<String> operatingZone;
  List<String> problems;

  Device(
      {this.deviceId, this.type, this.name, this.operatingZone, this.problems});

  Future<Device> fetchDevice(String deviceId) async {
    var devices = await FirebaseDB().fetchData('device', deviceId);
    return Device(
      deviceId: devices['deviceId'],
      type: devices['type'],
      name: devices['name'],
      operatingZone: devices['operatingZone'],
      problems: devices['problem'],
    );
  }

  static List<Device> fetchSample() {
    return [
      Device(
        deviceId: 'u0001',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        problems: ['none'],
      ),
      Device(
        deviceId: 'u0002',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        problems: ['none'],
      )
    ];
  }
}
