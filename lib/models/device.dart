import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';

class Device {
  String deviceId = '';
  String type = '';
  String name = '';
  List<String> operatingZone = [];
  // CollectionReference deviceProblems;

  Device({
    this.deviceId,
    this.type,
    this.name,
    this.operatingZone,
    /*this.deviceProblems*/
  });

  void fetchDevice(String deviceId) {
    FirebaseDB().fetchData('device', deviceId).then((device) {
      this.deviceId = device['deviceId'];
      this.type = device['type'];
      this.name = device['name'];
      this.operatingZone = device['operatingZone'];
      // this.deviceProblems = device['deviceId'];
    });
    // return Device(
    //   deviceId: devices['deviceId'],
    //   type: devices['type'],
    //   name: devices['name'],
    //   operatingZone: devices['operatingZone'],
    //   problems: devices['problem'],
    // );
  }

  Device defaultValue() =>
      Device(deviceId: '0000', name: "default", operatingZone: ['none']);

  static List<Device> fetchSamples() {
    return [
      Device(
        deviceId: 'u0001',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        // problems: ['none'],
      ),
      Device(
        deviceId: 'u0002',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        // problems: ['none'],
      )
    ];
  }
}
