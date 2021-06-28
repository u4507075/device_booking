import 'package:flutter/material.dart';
import './device_service.dart';

class Device {
  String? name = ''; //deviceName
  String? deviceId = ''; //deviceId
  String? deviceType = ''; //type of device e.g. ultrasound / ekg
  String? location = ''; //Current location
  String? lastUserId = ''; //last user's uid
  String? lastUser = ''; //last user's name
  String? lastUserPhoneNumber = ''; //last user's phone number
  DateTime? lastUseTime; //last use time
  bool? inUse; //device's status
  bool? maintenance;
  List<dynamic>? operatingZone = [''];
  String? defaultLocation = '';
  String? photoURL = '';

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
      this.defaultLocation,
      this.photoURL});

  factory Device.fromMap(Map map) => Device(
        name: map['name'] ?? '',
        deviceId: map['deviceId'] ?? '',
        deviceType: map['deviceType'] ?? '',
        location: map['location'] ?? '',
        lastUserId: map['lastUserId'] ?? '',
        lastUser: map['lastUser'] ?? '',
        lastUserPhoneNumber: map['lastUserPhoneNumber'] ?? '',
        lastUseTime:
            DateTime.tryParse(map['lastUseTime']?.toDate()?.toString() ?? ''),
        // timestamp & Datetime conversion - ref: https://flutteragency.com/how-to-print-firestore-timestamp-as-formatted-date-and-time-in-flutter/
        // try parse = parse + null safety - ref: https://stackoverflow.com/questions/63019766/how-to-handle-dates-if-they-are-null-on-dart
        maintenance: map['maintenance'] ?? false,
        inUse: map['inUse'],
        operatingZone: map['operatingZone'] ?? [],
        defaultLocation: map['defaultLocation'] ?? '',
        photoURL: map['photoURL'] ?? '',
      );

  // Device sample() => Device(
  //     name: 'tester1',
  //     deviceId: 'defaultId',
  //     deviceType: 'ultrasound',
  //     location: 'defaultLocation',
  //     lastUserId: 'xxx',
  //     lastUser: 'xxx',
  //     lastUserPhoneNumber: 'xxx',
  //     lastUseTime: DateTime.now(),
  //     inUse: false,
  //     maintenance: false,
  //     operatingZone: ['หอ1', 'หอ2', 'หอ3'],
  //     defaultLocation: 'defaultDefaultLocation');

// //fetch info, take, return, report

//   //fetch info
//   Future<Device> fetchDevice(String deviceId) async =>
//       DeviceService().fetchDevice(deviceId);

//   Future<void> addNewDevice(Device device) async =>
//       DeviceService().addNewDevice(device);

//   //take
//   Future<void> takeDevice(
//           {@required String deviceId,
//           @required String userId,
//           @required String location}) async =>
//       DeviceService().takeDevice(deviceId, userId, location);

//   //return
//   Future<void> returnDevice(
//           {@required String deviceId, @required String userId}) async =>
//       DeviceService().returnDevice(device, user);

//   //report{
//   Future<void> reportDevice(
//           {@required String deviceId,
//           @required String userId,
//           @required String reportText}) =>
//       DeviceService().reportDevice(deviceId, userId, reportText);
}

// Map<String, dynamic> toMap(Device device) => {
//       'name': device.name,
//       'deviceId': device.deviceId,
//       'deviceType': device.deviceType,
//       'location': device.location,
//       'defaultLocation': device.defaultLocation,
//       'lastUserId': device.lastUserId,
//       'lastUser': device.lastUser,
//       'lastUserPhoneNumber': device.lastUserPhoneNumber,
//       'inUse': false,
//       'maintenance': false,
//       'operatingZone': device.operatingZone,
//     };

//TODO Take this "Device list" to local controller
// class UltrasoundDeviceList {
//   List<Device> devices;

//   UltrasoundDeviceList({this.devices});

//   factory UltrasoundDeviceList.initialValue() =>
//       UltrasoundDeviceList(devices: []);

//   // get list of device (ultrasound / ekg / etc.)
//   Future<UltrasoundDeviceList> fetchDeviceList() => DBService()
//       .fetchDeviceList('ultrasound')
//       .then((devices) => UltrasoundDeviceList(devices: devices));

//   Stream<UltrasoundDeviceList> streamDeviceList() =>
//       DBService().streamUltrasoundDeviceList('ultrasound');
// }

// class EkgDeviceList {
//   List<Device> devices;

//   EkgDeviceList({this.devices});

//   factory EkgDeviceList.initialValue() => EkgDeviceList(devices: []);

//   Stream<EkgDeviceList> streamDeviceList() =>
//       DBService().streamEkgDeviceList('ekg');
// }

// class DeviceList {
//   List<Device> devices;

//   DeviceList({this.devices});

//   factory DeviceList.initialValue() => DeviceList(devices: []);

//   // get list of device (ultrasound / ekg / etc.)
//   Future<DeviceList> fetchDeviceList(String deviceType) => DBService()
//       .fetchDeviceList(deviceType)
//       .then((devices) => DeviceList(devices: devices));

//   Stream<DeviceList> streamDeviceList(String deviceType) {
//     return DBService().streamDeviceList(deviceType);
//   }
// }
