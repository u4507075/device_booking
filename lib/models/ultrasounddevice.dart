import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';

class UltrasoundDevice {
  String name; //deviceName
  String deviceId; //deviceId
  String location; //Current location
  String lastUserId; //last user's uid
  String lastUser; //last user's name
  String lastUserPhoneNumber; //last user's phone number
  DateTime lastUseTime; //last use time
  bool inUse; //device's status
  bool maintenance;
  List<dynamic> operatingZone;
  String defaultLocation;

  UltrasoundDevice(
      {this.name,
      this.deviceId,
      this.location,
      this.lastUserId,
      this.lastUser,
      this.lastUserPhoneNumber,
      this.lastUseTime,
      this.inUse,
      this.maintenance,
      this.operatingZone,
      this.defaultLocation});

  factory UltrasoundDevice.fromMap(Map map) {
    return UltrasoundDevice(
      name: map['name'] ?? '',
      deviceId: map['deviceId'] ?? '',
      location: map['location'] ?? '',
      lastUserId: map['lastUserId'] ?? '',
      lastUser: map['lastUser'] ?? '',
      lastUserPhoneNumber: map['lastUserPhoneNumber'] ?? '',
      lastUseTime: DateTime.parse(map['lastUseTime'].toDate().toString()),
      //ref: https://flutteragency.com/how-to-print-firestore-timestamp-as-formatted-date-and-time-in-flutter/
      maintenance: map['maintenance'] ?? false,
      operatingZone: map['operatingZone'] ?? [],
      defaultLocation: map['defaultLocation'] ?? '',
    );
  }
  //fetch info, take, return, report

  //fetch info
  Future<UltrasoundDevice> fetchDevice(String deviceId) async {
    return DBService().fetchUltrasoundDevice(deviceId);
  }

  //take
  Future<void> takeDevice(
      {@required String deviceId,
      @required String userId,
      @required String location}) async {
    return DBService().takeUltrasoundDevice(deviceId, userId, location);
  }
}
