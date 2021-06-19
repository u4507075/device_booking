import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/core/core.dart';

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

/* -------------------------------User------------------------------------ */

/* -------------------------------Device------------------------------------ */

/* -----------------------------DeviceList--------------------------------- */

//TODO Take this "fetchDeviceList" to local service

  // Future<List<Device>> fetchDeviceList(String deviceType) async {
  //   try {
  //     QuerySnapshot querySnapshot = await _db
  //         .collection("devices")
  //         .where('deviceType', isEqualTo: deviceType)
  //         .get();
  //     print('${querySnapshot.size} device(s) found');
  //     return querySnapshot.docs.map((doc) {
  //       Map<String, dynamic> device = doc.data();
  //       if (doc.exists) {
  //         return Device.fromMap(device);
  //       } else {
  //         return null;
  //       }
  //     }).toList();
  //   } catch (e) {
  //     print('fetch list failed with error: ${e.toString()}');
  //     return null;
  //   }
  // }

  // Stream<DeviceList> streamDeviceList(String deviceType) {
  //   try {
  //     return _db
  //         .collection("devices")
  //         .where('deviceType', isEqualTo: deviceType)
  //         .snapshots()
  //         .map((QuerySnapshot querySnapshot) {
  //       return DeviceList(
  //           devices: querySnapshot.docs.map((doc) {
  //         return Device.fromMap(doc.data());
  //       }).toList());
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Stream<UltrasoundDeviceList> streamUltrasoundDeviceList(String deviceType) {
  //   try {
  //     return _db
  //         .collection("devices")
  //         .where('deviceType', isEqualTo: deviceType)
  //         .snapshots()
  //         .map((QuerySnapshot querySnapshot) {
  //       return UltrasoundDeviceList(
  //           devices: querySnapshot.docs.map((doc) {
  //         return Device.fromMap(doc.data());
  //       }).toList());
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Stream<EkgDeviceList> streamEkgDeviceList(String deviceType) {
  //   try {
  //     return _db
  //         .collection("devices")
  //         .where('deviceType', isEqualTo: deviceType)
  //         .snapshots()
  //         .map((QuerySnapshot querySnapshot) {
  //       return EkgDeviceList(
  //           devices: querySnapshot.docs.map((doc) {
  //         return Device.fromMap(doc.data());
  //       }).toList());
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
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
