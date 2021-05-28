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
