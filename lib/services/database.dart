import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/models/device.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/models/user.dart';

import 'package:device_booking/models/device/devicestatus.dart';

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

/* -------------------------------User------------------------------------ */

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
        'inUse': false
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
      }).then((value) => print('Update user successful ${user.firstname}'));
    } catch (e) {
      print('Update user failed ${e.toString()}');
    }
  }

  //Get UserData one time
  Future<UserData> fetchUser(String id) async {
    var snap = await _db.collection('users').doc(id).get();
    if (snap.exists) {
      return UserData.fromMap(snap.data());
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
        'lastUserId': device.lastUserId,
        'lastUser': device.lastUser,
        'lastUserPhoneNumber': device.lastUserPhoneNumber,
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

  Stream<Device> streamDevice(String deviceId) {
    try {
      // print('Stream $deviceId');
      return _db
          .collection('devices')
          .doc(deviceId)
          .snapshots()
          .map((snap) => Device.fromMap(snap.data()));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> takeDevice(
      String deviceId, String userId, String location) async {
    //TODO may consider to change userId to Provider<UserData> in the future to lower read&write
    //update device inUse, deviceLogs, UserLogs

    CollectionReference user = _db.collection('users');
    CollectionReference devices = _db.collection('devices');
    CollectionReference deviceLogs =
        devices.doc(deviceId).collection('deviceLogs');
    Timestamp now = Timestamp.fromDate(DateTime.now());

    try {
      //fetch userData to
      UserData userData = await fetchUser(userId);
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
      DocumentReference docRef = deviceLogs.doc();
      docRef.set({
        'deviceId': deviceId,
        'logId': docRef.id,
        'userId': userData.uid,
        'take': true,
        'useTime': now,
      });

      //add userLog
      user.doc(userData.uid).collection('userLogs').doc(docRef.id).set({
        'uid': userData.uid,
        'deviceId': deviceId,
        'take': true,
        'logId': docRef.id,
        'time': now,
      });

      //switch user inUse status
      user.doc(userData.uid).update({'inUse': true});
      userData.userInUse();

      print('Device - takeDevice() successful');
    } catch (e) {
      print('Device - takeDevice() unsuccessful: return error ${e.toString()}');
    }
  }

  Future<void> returnDevice(String deviceId, String userId) async {
    CollectionReference user = _db.collection('users');
    CollectionReference devices = _db.collection('devices');
    CollectionReference deviceLogs =
        devices.doc(deviceId).collection('deviceLogs');
    Timestamp now = Timestamp.fromDate(DateTime.now());

    try {
      //fetch userData to
      UserData userData = await fetchUser(userId);
      Device device = await fetchDevice(deviceId);
      //update device inUse
      devices.doc(deviceId).update({
        'inUse': false, //not inUse
        'lastUser':
            '${userData.role} ${userData.firstname} ${userData.lastname}',
        'lastUserId': userData.uid,
        'lastUserPhoneNumber': userData.phoneNumber,
        'location': device.defaultLocation, //location back to default location
        'lastUseTime': now,
      });

      //add deviceLog
      DocumentReference docRef = deviceLogs.doc();
      docRef.set({
        'deviceId': deviceId,
        'logId': docRef.id,
        'userId': userData.uid,
        'take': false, //return
        'useTime': now,
      });

      //add userLog
      user.doc(userData.uid).collection('userLogs').doc(docRef.id).set({
        'uid': userData.uid,
        'deviceId': deviceId,
        'take': false, //return
        'logId': docRef.id,
        'time': now,
      });

      //switch user inUse status
      user.doc(userData.uid).update({'inUse': false});
      userData.userReturn();

      print('Device - returnDevice() successful');
    } catch (e) {
      print(
          'Device - returnDevice() unsuccessful : return error ${e.toString()}');
    }
  }

  //report device problem
  Future<void> reportDevice(
      String deviceId, String userId, String reportText) async {
    CollectionReference deviceProblems =
        _db.collection('devices').doc(deviceId).collection('deviceProblems');
    Timestamp now = Timestamp.fromDate(DateTime.now());
    DocumentReference docRef = deviceProblems.doc();

    try {
      docRef.set({
        'deviceId': deviceId,
        'userId': userId,
        'reportId': docRef.id,
        'reportTime': now,
        'problem': reportText,
      });
    } catch (e) {}
  }

/* -----------------------------DeviceList--------------------------------- */

  Future<List<Device>> fetchDeviceList(String deviceType) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection("devices")
          .where('deviceType', isEqualTo: deviceType)
          .get();
      print('${querySnapshot.size} device(s) found');
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> device = doc.data();
        if (doc.exists) {
          return Device.fromMap(device);
        } else {
          return null;
        }
      }).toList();
    } catch (e) {
      print('fetch list failed with error: ${e.toString()}');
      return null;
    }
  }

  Stream<DeviceList> streamDeviceList(String deviceType) {
    try {
      return _db
          .collection("devices")
          .where('deviceType', isEqualTo: deviceType)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return DeviceList(
            devices: querySnapshot.docs.map((doc) {
          return Device.fromMap(doc.data());
        }).toList());
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<UltrasoundDeviceList> streamUltrasoundDeviceList(String deviceType) {
    try {
      return _db
          .collection("devices")
          .where('deviceType', isEqualTo: deviceType)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return UltrasoundDeviceList(
            devices: querySnapshot.docs.map((doc) {
          return Device.fromMap(doc.data());
        }).toList());
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<EkgDeviceList> streamEkgDeviceList(String deviceType) {
    try {
      return _db
          .collection("devices")
          .where('deviceType', isEqualTo: deviceType)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return EkgDeviceList(
            devices: querySnapshot.docs.map((doc) {
          return Device.fromMap(doc.data());
        }).toList());
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

/*





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
 */
