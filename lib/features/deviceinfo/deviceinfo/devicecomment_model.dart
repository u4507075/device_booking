import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DeviceComment {
  String commentId;
  String comment = '';
  String deviceId;
  String userId;
  String displayName;
  String userPhotoURL;
  DateTime time;

  DeviceComment(
      {this.commentId,
      this.deviceId,
      this.userId,
      this.comment,
      this.displayName,
      this.userPhotoURL,
      this.time});
  // _comment = comment;

  void set setComment(String text) {
    comment = text;
  }

  factory DeviceComment.fromMap(Map map) => DeviceComment(
        commentId: map['commentId'] ?? '',
        deviceId: map['deviceId'] ?? '',
        comment: map['comment'] ?? '',
        userId: map['userId'] ?? '',
        // displayName: map['displayName'] ?? '',
        // userPhotoURL: map['userPhotoURL'] ?? '',
        time: DateTime.tryParse(map['time']?.toDate()?.toString() ?? ''),
      );
}
