import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/devicestatus.dart';
import 'package:device_booking/models/Userdetail.dart';

class DBService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchData(String field, String document) async {
    CollectionReference doc = FirebaseFirestore.instance.collection(field);
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data();
      return data;
    } else {
      return null;
    }
  }

  Future<Device> fetchDevice(String document) async {
    CollectionReference doc = FirebaseFirestore.instance.collection('devices');
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> device = documentSnapshot.data();
      return Device(
          deviceId: device['deviceId'],
          type: device['type'],
          name: device['name'],
          operatingZone: device['operatingZone']);
    } else {
      return null;
    }
  }

  Future<DeviceStatus> fetchDeviceStatus(String document) async {
    CollectionReference doc =
        FirebaseFirestore.instance.collection('device_status');
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> device_status = documentSnapshot.data();
      return DeviceStatus(
          status: device_status['status'],
          timestamp: device_status['timestamp'],
          userid: device_status['userid'],
          borrowPlace: device_status['BorrowPlace']);
    } else {
      return null;
    }
  }

  Future<UserDetails> fetchUserDetails(String document) async {
    CollectionReference doc =
        FirebaseFirestore.instance.collection('users_testpull');
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> users_testpull = documentSnapshot.data();
      return UserDetails(
          email: users_testpull['email'],
          firstname: users_testpull['firstname'],
          imagePath: users_testpull['imagePath'],
          lastname: users_testpull['lastname'],
          role: users_testpull['role'],
          telephone: users_testpull['telephone']);
    } else {
      return null;
    }
  }

  // void updateStatus(FirebaseApp app, String deviceId, String uid, , ) {
  //   FirebaseDatabase database = FirebaseDatabase(app: app);
  //   final ref = database.reference();
  //   ref.child(deviceId).push().set(<String, String>{
  //     "date": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())

  //     //Add user id
  //     //Add device id
  //     //Add status borrow / return
  //   });
  // }

  void updateStatus(FirebaseApp app, String deviceId) {
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref.child(deviceId).push().set(<String, String>{
      "date": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      //Add user id
      //Add device is
      //Add status borrow / return
    });
  }

  void listenStatusChange(FirebaseApp app, String deviceId) {
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref.child(deviceId).limitToLast(1).onChildAdded.listen((event) {
      Map<String, dynamic> data =
          new Map<String, dynamic>.from(event.snapshot.value);
      print(data["date"]);
    });
  }

  Future<String> getTime(FirebaseApp app,
      StreamController<String> _controllerTime, String deviceId) {
    FirebaseDatabase database = FirebaseDatabase(app: app);
    final ref = database.reference();
    ref.child(deviceId).limitToLast(1).onChildAdded.listen((event) {
      Map<String, dynamic> data =
          new Map<String, dynamic>.from(event.snapshot.value);
      print(data["date"]);
      String datetime = data["date"];
      var time = const Duration(milliseconds: 900);
      Timer.periodic(time, (timer) {
        var dateTime1 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(datetime);
        final hrs = DateTime.now().difference(dateTime1).inHours;
        final mins = DateTime.now().difference(dateTime1).inMinutes;
        final secs = DateTime.now().difference(dateTime1).inSeconds;
        int min = mins % 60;
        int sec = secs % 60;
        if (hrs == 0) {
          _controllerTime.add('$min minutes $sec secs');
          if (min == 0) {
            _controllerTime.add('$sec secs');
          } else {
            _controllerTime.add('$min minutes $sec secs');
          }
        } else {
          _controllerTime.add('$hrs hours $min minutes $sec secs');
          if (min == 0) {
            _controllerTime.add('$hrs hours $sec secs');
          } else {
            _controllerTime.add('$hrs hours $min minutes $sec secs');
          }
        }
        print('$hrs hours $min minutes $sec secs');
      });
    });
  }

  //Get UserData one time
  Future<UserData> getUser(String id) async {
    var snap = await _db.collection('users').doc(id).get();
    return UserData.fromMap(snap.data());
  }

  Future<bool> checkUser(String id) {
    return _db.collection('users').doc(id).get().then((snap) {
      return snap.exists;
    });
  }

  //Stream UserData
  Stream<UserData> streamUserData(String uid) {
    try {
      return _db
          .collection('users')
          .doc(uid)
          .snapshots()
          .map((snap) => UserData.fromMap(snap.data()));
    } catch (e) {
      print(e.toString());
      return null;
    }
  } //ref: https://www.youtube.com/watch?v=vFxk_KJCqgk ['Provider and flutterfire']

  Future<void> addUser(UserData userData) {
    return _db.collection('users').doc(userData.uid).set({
      'firstname': userData.firstname,
      'lastname': userData.lastname,
      'email': userData.email,
      'phoneNumber': userData.phoneNumber,
      'role': userData.role,
      'uid': userData.uid,
    }, SetOptions(merge: true));
  }
}
