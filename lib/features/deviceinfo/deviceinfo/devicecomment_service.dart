import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/core/auth/user_service.dart';
import 'package:flutter/material.dart';
import './devicecomment_model.dart';
import 'package:device_booking/core/core.dart';

class DeviceCommentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DeviceComment?>?> fetchDeviceComments(String? deviceId,
      {int numbers = 5}) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection("devices")
          .doc(deviceId)
          .collection('deviceComments')
          .orderBy('time')
          .limitToLast(numbers) //default -> get last 5 comments
          .get();

      print('${querySnapshot.size} device comment(s) found');

      return querySnapshot.docs.map((doc) {
        DeviceComment deviceComment =
            DeviceComment.fromMap(doc.data() as Map<String, dynamic>);
        if (doc.exists) {
          // await UserDataService().fetchUser(deviceComment.userId);
          return deviceComment;
        } else {
          return null;
        }
      }).toList();
    } catch (e) {
      print('fetch device comment list failed with error: ${e.toString()}');
      return null;
    }
  }

  // Stream<List<DeviceComment>> streamDeviceComments(String deviceId,
  //     {int numbers = 5}) {
  //   try {
  //     return _db
  //         .collection("devices")
  //         .doc(deviceId)
  //         .collection('deviceComments')
  //         .orderBy('time')
  //         .limitToLast(numbers)
  //         .snapshots()
  //         .map((QuerySnapshot querySnapshot) {
  //       return querySnapshot.docs.map((doc) {
  //         return DeviceComment.fromMap(doc.data());
  //       }).toList();
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Stream<List<DeviceComment>>? streamDeviceComments(String deviceId,
      {int numbers = 5}) {
    try {
      return _db
          .collection("devices")
          .doc(deviceId)
          .collection('deviceComments')
          .orderBy('time')
          .limitToLast(numbers)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          var deviceComment =
              DeviceComment.fromMap(doc.data() as Map<dynamic, dynamic>);

          // var userStream =
          //     UserDataService().streamUserData(deviceComment.userId);
          // // userStream?.asBroadcastStream();
          // userStream?.asBroadcastStream().listen((user) {
          //   deviceComment.setDisplayName = user.firstname;
          //   deviceComment.setUserPhotoURL = user.photoURL;
          // });
          // return deviceComment;
          // Stream.fromFuture(UserDataService().fetchUser(deviceComment.userId))
          //     .listen((user) {
          //   deviceComment.setDisplayName = user?.firstname ?? '';
          //   deviceComment.setUserPhotoURL = user?.photoURL ?? '';
          // });
          return deviceComment;

//        UserDataService()
//               .fetchUser(deviceComment.userId)
//               .then((user) {
// deviceComment.setDisplayName = user?.firstname ?? '';
//           deviceComment.setUserPhotoURL = user?.photoURL ?? '';
//           return deviceComment;
//               });
        }).toList();
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> addDeviceComment(DeviceComment deviceComment) async {
    CollectionReference deviceComments = _db
        .collection('devices')
        .doc(deviceComment.deviceId)
        .collection('deviceComments');
    DocumentReference docRef = deviceComments.doc();
    Timestamp now = Timestamp.fromDate(DateTime.now());
    try {
      return docRef.set({
        'comment': deviceComment.comment,
        'commentId': docRef.id,
        'deviceId': deviceComment.deviceId,
        'time': now,
        'userId': deviceComment.userId,
        // 'displayName': deviceComment.displayName,
        // 'userPhotoURL': deviceComment.userPhotoURL,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteComment(DeviceComment deviceComment) async {
    DocumentReference deviceCommentDoc = _db
        .collection('devices')
        .doc(deviceComment.deviceId)
        .collection('deviceComments')
        .doc(deviceComment.commentId);

    return deviceCommentDoc
        .delete()
        .then((_) => print('Comment deleted'))
        .catchError((error) => print("Failed to delete user: $error"));
  }

//TODO find a way to be able to save previous comment as well
  // Future<void> editDeviceComment(DeviceComment deviceComment) async {
  //   DocumentReference deviceComments = _db
  //       .collection('devices')
  //       .doc(deviceComment.deviceId)
  //       .collection('deviceComments').doc(deviceComment.commentId);
  //   // DocumentReference docRef = deviceComments.doc();
  //   Timestamp now = Timestamp.fromDate(DateTime.now());

  //   try {
  //     return docRef.set({
  //       'comment': deviceComment.comment,
  //       'commentId': docRef.id,
  //       'deviceId': deviceComment.deviceId,
  //       'time': now,
  //       'userId': deviceComment.userId,
  //       'displayName': deviceComment.displayName,
  //       'userPhotoURL': deviceComment.userPhotoURL,
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

}
