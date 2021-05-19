import 'package:flutter/material.dart';

class Device {
  String deviceId;
  String type;
  String name;
  List<String> operatingZone;
  String problem;

  Device(
      {this.deviceId, this.type, this.name, this.operatingZone, this.problem});

  static List<Device> fetchAll() {
    return [
      Device(
        deviceId: 'u0001',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        problem: 'none',
      ),
      Device(
        deviceId: 'u0002',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        problem: 'none',
      )
    ];
  }
}
