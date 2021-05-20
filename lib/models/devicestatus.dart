import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';

class DeviceStatus {
  String status = '';
  String timestamp = '';
  String userid = '';


  DeviceStatus({
    this.status,
    this.timestamp,
    this.userid,
  });

  DeviceStatus defaultValue() =>
      DeviceStatus(status: 'unknown',
          timestamp: "0000-00-00 00:00:00",
          userid: "000000");
}