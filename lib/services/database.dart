import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/ultrasounddevice.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/models/device2.dart';
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

  Future<Device2> fetchDevice2(String document) async {
    CollectionReference doc = FirebaseFirestore.instance.collection('devices');
    DocumentSnapshot documentSnapshot = await doc.doc(document).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> device = documentSnapshot.data();
      return Device2(
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
  Future<UserData> fetchUserData(String id) async {
    var snap = await _db.collection('users').doc(id).get();
    if (snap.exists) {
      return UserData.fromMap(snap.data());
    } else {
      return null;
    }
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
    });
  }

  Future<UltrasoundDevice> fetchUltrasoundDevice(String deviceId) async {
    CollectionReference ultrasoundDevices =
        FirebaseFirestore.instance.collection('ultrasoundDevices');
    DocumentSnapshot documentSnapshot =
        await ultrasoundDevices.doc(deviceId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> device = documentSnapshot.data();
      print('Retrieve device info successful: ${device['name']}');
      print(device['lastUseTime'].toDate().toString());
      return UltrasoundDevice.fromMap(device);
    } else {
      print('Failed to retrieve device info');
      return null;
    }
  }

  Future<void> takeUltrasoundDevice(
      String deviceId, String userId, String location) async {
    //TODO may consider to change userId to Provider<UserData> in the future to lower read&write
    //update device inUse, deviceLog, UserLog
    CollectionReference user = _db.collection('users');
    CollectionReference devices = _db.collection('ultrasoundDevices');
    CollectionReference deviceLog =
        devices.doc(deviceId).collection('deviceLog');
    Timestamp now = Timestamp.fromDate(DateTime.now());

    try {
      //fetch userData to
      UserData userData = await fetchUserData(userId);
      //update device inUse
      devices.doc(deviceId).update({
        'inUse': true,
        'lastUser':
            '${userData.role} ${userData.firstname} ${userData.lastname}',
        'lastUserId': userData.uid,
        'lastUserPhoneNumber': userData.phoneNumber,
        'location': location,
        'lastUseTime': now,
      });

      //add deviceLog
      DocumentReference docRef = deviceLog.doc();
      docRef.set({
        'deviceId': deviceId,
        'logId': docRef.id,
        'userId': userData.uid,
        'take': true,
        'useTime': now,
      });

      user.doc(userData.uid).collection('userLog').doc(docRef.id).set({
        'uid': userData.uid,
        'deviceId': deviceId,
        'take': true,
        'logId': docRef.id,
        'time': now,
      });

      //add userLog
    } catch (e) {
      print('Take device unsuccessful: return error ${e.toString()}');
    }
  }

/* -------------------------------Device------------------------------------ */

  Future<void> addNewDevice(Device device) async {
    CollectionReference devices = _db.collection('devices');
    DocumentReference docRef = devices.doc();
    try {
      return docRef.set({
        'name': device.name,
        'deviceId': docRef.id,
        'deviceType': device.deviceType,
        'location': device.location,
        'defaultLocation': device.defaultLocation,
        'inUse': false,
        'maintenance': false,
        'operatingZone': device.operatingZone,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Device> fetchDevice(String deviceId) async {
    CollectionReference devices =
        FirebaseFirestore.instance.collection('devices');
    DocumentSnapshot documentSnapshot = await devices.doc(deviceId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> device = documentSnapshot.data();
      print(
          'Retrieve device info successful: ${device['name']}, ${device['deviceType']}');
      print(device['lastUseTime']?.toDate().toString());
      return Device.fromMap(device);
    } else {
      print('Failed to retrieve device info');
      return null;
    }
  }

  Future<void> takeDevice(
      String deviceId, String userId, String location) async {
    //TODO may consider to change userId to Provider<UserData> in the future to lower read&write
    //update device inUse, deviceLogs, UserLogs
    print('Device: takeDevice()');
    CollectionReference user = _db.collection('users');
    CollectionReference devices = _db.collection('devices');
    CollectionReference deviceLog =
        devices.doc(deviceId).collection('deviceLogs');
    Timestamp now = Timestamp.fromDate(DateTime.now());

    try {
      //fetch userData to
      UserData userData = await fetchUserData(userId);
      //update device inUse
      devices.doc(deviceId).update({
        'inUse': true,
        'lastUser':
            '${userData.role} ${userData.firstname} ${userData.lastname}',
        'lastUserId': userData.uid,
        'lastUserPhoneNumber': userData.phoneNumber,
        'location': location,
        'lastUseTime': now,
      });

      //add deviceLog
      DocumentReference docRef = deviceLog.doc();
      docRef.set({
        'deviceId': deviceId,
        'logId': docRef.id,
        'userId': userData.uid,
        'take': true,
        'useTime': now,
      });

      user.doc(userData.uid).collection('userLog').doc(docRef.id).set({
        'uid': userData.uid,
        'deviceId': deviceId,
        'take': true,
        'logId': docRef.id,
        'time': now,
      });

      //add userLog
    } catch (e) {
      print('Take device unsuccessful: return error ${e.toString()}');
    }
  }
}
