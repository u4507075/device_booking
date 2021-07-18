import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DeviceProblem {
  String? deviceId, problem, reportId, userId;
  DateTime? reportTime;

  DeviceProblem(
      {this.deviceId,
      this.problem,
      this.reportId,
      this.userId,
      this.reportTime});

  factory DeviceProblem.fromMap(Map map) => DeviceProblem(
        reportId: map['reportId'] ?? '',
        deviceId: map['deviceId'] ?? '',
        problem: map['problem'] ?? '',
        userId: map['userId'] ?? '',
        reportTime:
            DateTime.tryParse(map['reportTime']?.toDate()?.toString() ?? ''),
      );
}
