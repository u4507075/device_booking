class EkgDevice {
  String name; //deviceName
  String deviceId;
  String location; //Current location
  String lastUserId; //last user's uid
  String lastUser;
  String lastUserPhoneNumber;
  DateTime lastUseTime; //last use time
  bool inUse;
  bool maintenance;
  List<dynamic> operatingZone;

  EkgDevice(
      {this.name,
      this.deviceId,
      this.location,
      this.lastUserId,
      this.lastUser,
      this.lastUserPhoneNumber,
      this.lastUseTime,
      this.inUse,
      this.maintenance,
      this.operatingZone});

  factory EkgDevice.fromMap(Map map) {
    return EkgDevice(
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
    );
    //take, return, report
  }
}
