import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';

class Device {
  String name; //deviceName
  String deviceId; //deviceId
  String deviceType; //type of device e.g. ultrasound / ekg
  String location; //Current location
  String lastUserId; //last user's uid
  String lastUser; //last user's name
  String lastUserPhoneNumber; //last user's phone number
  DateTime lastUseTime; //last use time
  bool inUse; //device's status
  bool maintenance;
  List<dynamic> operatingZone;
  String defaultLocation;

  Device(
      {this.name,
      this.deviceId,
      this.deviceType,
      this.location,
      this.lastUserId,
      this.lastUser,
      this.lastUserPhoneNumber,
      this.lastUseTime,
      this.inUse,
      this.maintenance,
      this.operatingZone,
      this.defaultLocation});

  factory Device.fromMap(Map map) {
    return Device(
      name: map['name'] ?? '',
      deviceId: map['deviceId'] ?? '',
      deviceType: map['deviceType'] ?? '',
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

  Device sample() {
    return Device(
        name: 'tester1',
        deviceId: 'defaultId',
        deviceType: 'ultrasound',
        location: 'defaultLocation',
        lastUserId: 'xxx',
        lastUser: 'xxx',
        lastUserPhoneNumber: 'xxx',
        lastUseTime: DateTime.now(),
        inUse: false,
        maintenance: false,
        operatingZone: ['หอ1', 'หอ2', 'หอ3'],
        defaultLocation: 'defaultDefaultLocation');
  }

//fetch info, take, return, report

  //fetch info
  Future<Device> fetchDevice(String deviceId) async {
    return DBService().fetchDevice(deviceId);
  }

  Future<void> addNewDevice(Device device) async {
    return DBService().addNewDevice(device);
  }

  //take
  Future<void> takeDevice(
      {@required String deviceId,
      @required String userId,
      @required String location}) async {
    return DBService().takeDevice(deviceId, userId, location);
  }

  //return
  Future<void> returnDevice(
      {@required String deviceId, @required String userId}) async {
    return DBService().returnDevice(deviceId, userId);
  }

  //report{
  Future<void> reportDevice(
      {@required String deviceId,
      @required String userId,
      @required String reportText}) {
    return DBService().reportDevice(deviceId, userId, reportText);
  }
}

// Map<String, dynamic> toMap(Device device) {
//   Map<String, dynamic> map;
//   return map = {
//     'name': device.name,
//       'deviceId': docRef.id,
//       'deviceType': device.deviceType,
//       'location': device.location,
//       'defaultLocation': device.defaultLocation,
//       'lastUserId': device.lastUserId,
//       'lastUser':device.lastUser,
//       'lastUserPhoneNumber': device.lastUserPhoneNumber,
//       'inUse': false,
//       'maintenance': false,
//       'operatingZone': device.operatingZone,
//   };
// }
