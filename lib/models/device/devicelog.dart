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
