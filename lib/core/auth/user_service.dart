import 'package:device_booking/core/device/device.dart';
import 'package:device_booking/core/device/device_service.dart';

import './user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<bool> checkUser(String id) {
    return _db.collection('users').doc(id).get().then((snap) {
      return snap.exists;
    });
  }

  //Stream UserData
  Stream<UserData>? streamUserData(String uid) {
    try {
      return _db
          .collection('users')
          .doc(uid)
          .snapshots()
          .map((snap) => UserData.fromMap(snap.data() ?? {}));
    } catch (e) {
      print(e.toString());
      return null;
    }
  } //ref: https://www.youtube.com/watch?v=vFxk_KJCqgk ['Provider and flutterfire']

  Future<void> registerNewUser(UserData user) async {
    try {
      _db.collection('users').doc(user.uid).set({
        'firstname': user.firstname,
        'lastname': user.lastname,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'photoURL': user.photoURL,
        'role': user.role,
        'uid': user.uid,
        'inUse': false,
        'admin': false,
        'timeCreated': DateTime.now()
      }).then((value) => print('Register user successful: ${user.firstname} '));
    } catch (e) {
      print('Register user failed: ${e.toString()} ');
    }
  }

  Future<void> updateUser(UserData user) async {
    try {
      _db.collection('users').doc(user.uid).update({
        'firstname': user.firstname,
        'lastname': user.lastname,
        'role': user.role,
        'phoneNumber': user.phoneNumber,
        'photoURL': user.photoURL,
      }).then((value) => print('Update user successful ${user.firstname}'));
    } catch (e) {
      print('Update user failed ${e.toString()}');
    }
  }

  //Get UserData one time
  Future<UserData?> fetchUser(String? userId) async {
    var snap = await _db.collection('users').doc(userId).get();
    if (snap.exists) {
      return UserData.fromMap(snap.data()!);
    } else {
      return null;
    }
  }

  //delete user
  Future<void> deleteUser(String uid) async {
    return _db
        .collection('users')
        .doc(uid)
        .delete()
        .then((value) => print('User deleted'))
        .catchError((e) => print('Failed to delete user: ${e.toString()}'));
  }

  Future<UserLog?> lastUserLog(String? userId) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('userLogs')
          .orderBy('time', descending: false)
          .limitToLast(1)
          .get();
      Map<String, dynamic> map =
          querySnapshot.docs[0].data() as Map<String, dynamic>;
      return UserLog.fromMap(map);
    } catch (e) {
      print('Get last userlog failed: ${e.toString()}');
      return null;
    }
  }

  Future<Device?> lastUseDevice(String userId) async {
    return lastUserLog(userId)
        .then(
            (userLog) => DeviceService().fetchDevice(userLog?.deviceId ?? ' '))
        .onError((error, stackTrace) => null);
  }

  // Stream<List<List<String>>> streamProfileList(String uid) {
  //   try {
  //     return _db.collection('users').doc(uid).snapshots().map((snap) {
  //       return [
  //         ['First name'],
  //         ['Last name'],
  //         ['Tel.'],
  //         ['Role']
  //       ];
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

}
