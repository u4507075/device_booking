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
  String? locatorId;
  DateTime? registerTime;

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
      this.photoURL,
      this.locatorId,
      this.registerTime});

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
        photoURL: map['photoURL'] ?? null,
        locatorId: map['locatorId'] ?? '',
        registerTime:
            DateTime.tryParse(map['registerTime']?.toDate()?.toString() ?? ''),
      );
}

class DeviceLocation {
  String? locationId;
  String? location;
  int? rssi;
  DateTime? time;
  String? timeLapsed;

  DeviceLocation(
      {this.locationId, this.rssi, this.location, this.time, this.timeLapsed});

  factory DeviceLocation.fromMap(Map map, Map locationDict) {
    // DateTime? now = DateTime.now();
    // var timeLapsed = timeFormat(DateTime.tryParse(map['timestamp'] ?? '')!);

    return DeviceLocation(
      locationId: map['location_id'] ?? '',
      location: locationDict[map['location_id'] ?? ''] ?? 'Unknown',
      rssi: map['rssi'] ?? null,
      time: DateTime.tryParse(map['timestamp'] ?? ''),
      // timeLapsed: ((map['timestamp'] ?? '') != '')
      //     ? now.difference(DateTime.tryParse(map['timestamp'] ?? '')!)
      //     : null,
      // timeLapsed: ((map['timestamp'] ?? '') != '')
      //     ? timeFormat(DateTime.tryParse(map['timestamp'] ?? '')!)
      //     : null,
    );
  }
}
