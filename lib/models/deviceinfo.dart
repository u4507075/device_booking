import 'package:flutter/material.dart';

class DeviceInfo {
  String status;
  String location;
  String name;
  String lastname;
  String date;
  String timebook;
  String timereturn;

  DeviceInfo(this.status, this.location, this.name, this.lastname, this.date,
      this.timebook, this.timereturn);

  static List<DeviceInfo> fetchAll() {
    return [];
  }
}
