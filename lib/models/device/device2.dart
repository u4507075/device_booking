import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';

class Device2 {
  String deviceId = '';
  String type = '';
  String name = '';
  List<dynamic> operatingZone = [];
  // CollectionReference deviceProblems;

  Device2({
    this.deviceId,
    this.type,
    this.name,
    this.operatingZone,
    /*this.deviceProblems*/
  });

  Device2 defaultValue() =>
      Device2(deviceId: '0000', name: "default", operatingZone: ['none']);

  static List<Device2> fetchSamples() {
    return [
      Device2(
        deviceId: 'u0001',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        // problems: ['none'],
      ),
      Device2(
        deviceId: 'u0002',
        type: 'ultrasound',
        name: 'Ultrasound อายุกรรมชาย 1',
        operatingZone: ['อายุรกรรมชาย 1', 'อายุรกรรมชาย 2', 'อายุรกรรมชาย 3'],
        // problems: ['none'],
      )
    ];
  }
}

class DeviceLog {
  String deviceId;
  String logId;
  String userId;
  bool take;
  DateTime useTime;

  DeviceLog({this.deviceId, this.logId, this.userId, this.take, this.useTime});

  factory DeviceLog.fromMap(Map map) {
    return DeviceLog(
      deviceId: map['deviceId'] ?? '',
      logId: map['logId'] ?? '',
      userId: map['userId'] ?? '',
      take: map['false'] ?? '',
      useTime: map['useTime'] ?? '',
    );
  }
}

class DeviceProblems {
  String deviceId;
  String reportId;
  String userId;
  String problem;
  DateTime reportTime;

  DeviceProblems(
      {this.deviceId,
      this.reportId,
      this.userId,
      this.problem,
      this.reportTime});

  factory DeviceProblems.fromMap(Map map) {
    return DeviceProblems(
      deviceId: map['deviceId'] ?? '',
      reportId: map['reportId'] ?? '',
      userId: map['userId'] ?? '',
      problem: map['problem'] ?? '',
      reportTime: map['reportTime'] ?? '',
    );
  }
}
