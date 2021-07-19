import 'package:cloud_firestore/cloud_firestore.dart';
import './device_model.dart';
import 'package:device_booking/core/auth/user.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:device_booking/core/';

class DeviceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addNewDevice(Device device) async {
    CollectionReference devices = _db.collection('devices');
    DocumentReference docRef = devices.doc();
    Timestamp now = Timestamp.fromDate(DateTime.now());
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
        'photoURL': device.photoURL,
        'locatorId': device.locatorId,
        'registerTime': now,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Device?> fetchDevice(String? deviceId) async {
    try {
      CollectionReference devices = _db.collection('devices');
      DocumentSnapshot documentSnapshot = await devices.doc(deviceId).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> device =
            documentSnapshot.data() as Map<String, dynamic>;
        print(
            'Retrieve device info successful: ${device['name']}, ${device['deviceType']}');
        print(device['lastUseTime']?.toDate().toString());
        return Device.fromMap(device);
        // return device;
      } else {
        print('Failed to retrieve device info');
        // return null;
      }
    } catch (e) {}
    print('Failed to retrieve device info');
    // return null;
  }

  Stream<Device>? streamDevice(String deviceId) {
    try {
      // print('Stream $deviceId');
      return _db
          .collection('devices')
          .doc(deviceId)
          .snapshots()
          .map((snap) => Device.fromMap(snap.data() ?? {}));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> takeDevice(Device device, UserData user, String location) async {
    CollectionReference users = _db.collection('users');
    CollectionReference devices = _db.collection('devices');
    CollectionReference deviceLogs =
        devices.doc(device.deviceId).collection('deviceLogs');
    Timestamp now = Timestamp.fromDate(DateTime.now());

    try {
      //fetch userData to
      // UserData? userData =
      //     await (UserDataService().fetchUser(user.uid) as Future<UserData?>)?;
      //update device inUse
      devices.doc(device.deviceId).update({
        'inUse': true,
        'lastUser': '${user.role} ${user.firstname} ${user.lastname}',
        'lastUserId': user.uid,
        'lastUserPhoneNumber': user.phoneNumber,
        'location': location,
        'lastUseTime': now,
      });

      if (device.inUse!) {
        //Force return - add deviceLog
        DocumentReference docRefForce = deviceLogs.doc();
        docRefForce.set({
          'deviceId': device.deviceId,
          'logId': docRefForce.id,
          'userId': device.lastUserId,
          'take': false, //return
          'useTime': now,
          'forceReturn': true,
        });

        //Force return - add userLog
        users.doc(user.uid).collection('userLogs').doc(docRefForce.id).set({
          'uid': device.lastUserId,
          'deviceId': device.deviceId,
          'take': false, //return
          'logId': docRefForce.id,
          'time': now,
          'forceReturn': true,
        });

        //Force return - update previous user inUse
        users.doc(device.lastUserId).update({'inUse': false});
      }

      //add deviceLog
      DocumentReference docRef = deviceLogs.doc();
      docRef.set({
        'deviceId': device.deviceId,
        'logId': docRef.id,
        'userId': user.uid,
        'take': true,
        'useTime': now,
        'location': location,
      });

      //add userLog
      users.doc(user.uid).collection('userLogs').doc(docRef.id).set({
        'uid': user.uid,
        'deviceId': device.deviceId,
        'take': true,
        'logId': docRef.id,
        'time': now,
        'location': location,
      });

      //switch user inUse status
      users.doc(user.uid).update({'inUse': true});
      // userData.userInUse(); //TODO add this to controller instead

      print('Device - takeDevice() successful');
    } catch (e) {
      print('Device - takeDevice() unsuccessful: return error ${e.toString()}');
    }
  }

  //

  Future<void> returnDevice(Device device, String userId) async {
    CollectionReference users = _db.collection('users');
    CollectionReference devices = _db.collection('devices');
    CollectionReference deviceLogs =
        devices.doc(device.deviceId).collection('deviceLogs');
    DocumentReference docRef = deviceLogs.doc();
    Timestamp now = Timestamp.fromDate(DateTime.now());

    try {
      //update device inUse
      devices.doc(device.deviceId).update({
        'inUse': false, //not inUse
        'location': device.defaultLocation, //location back to default location
        'lastUseTime': now,
      });

      //add deviceLog
      docRef.set({
        'deviceId': device.deviceId,
        'logId': docRef.id,
        'userId': userId,
        'take': false, //return
        'useTime': now,
        'forceReturn': false,
      });

      //add userLog
      users.doc(userId).collection('userLogs').doc(docRef.id).set({
        'uid': userId,
        'deviceId': device.deviceId,
        'take': false, //return
        'logId': docRef.id,
        'time': now,
      });

      //switch user inUse status
      users.doc(userId).update({'inUse': false});
      // user.userReturn(); //TODO change this to device controller

      print('Device - returnDevice() successful');
    } catch (e) {
      print(
          'Device - returnDevice() unsuccessful : return error ${e.toString()}');
    }
  }

  //report device problem
  Future<void> reportDevice(
      Device device, UserData user, String reportText) async {
    CollectionReference deviceProblems = _db
        .collection('devices')
        .doc(device.deviceId)
        .collection('deviceProblems');
    Timestamp now = Timestamp.fromDate(DateTime.now());
    DocumentReference docRef = deviceProblems.doc();

    try {
      docRef.set({
        'deviceId': device.deviceId,
        'userId': user.uid,
        'reportId': docRef.id,
        'reportTime': now,
        'problem': reportText,
        'reviewed': false,
        'repaired': false,
        'reviewTime': null,
        'repairTime': null,
      });
    } catch (e) {
      print('Report device error: ${e.toString()}');
    }
  }

  Future<Device?> lastUseDevice(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .doc(uid)
          .collection('userLogs')
          .orderBy('time')
          .limitToLast(1)
          .get();
      Map<String, dynamic> map =
          querySnapshot.docs[0].data() as Map<String, dynamic>;
      String? deviceId = map['deviceId'];
      return fetchDevice(deviceId);
    } catch (e) {
      print('getLastDeviceUse failed: ${e.toString()}');
      return null;
    }
  }

  //Implement on innit
  Future<Map<String, dynamic>> fetchProbeLocation() async {
    try {
      var map =
          (await _db.collection('utils').doc('probeLocation').get()).data();
      return map ?? {};
    } catch (e) {
      return {};
    }
  }

  Stream<Map<String, dynamic>> streamProbeLocation() {
    return fetchProbeLocation().asStream();
  }

  static Map<String, dynamic>? locationDict = {};

  // Stream<DeviceLocation>? streamLastDeviceLocation(String deviceId) {
  //   var tagLastLocationRef =
  //       FirebaseDatabase.instance.reference().child('tag_last_location');
  //   try {
  //     return tagLastLocationRef
  //         .child(deviceId)
  //         .onValue
  //         .map((map) => DeviceLocation.fromMap(map.snapshot.value));
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Stream<DeviceLocation>? streamDeviceLocation(String deviceId) async* {
    var tagLastLocationRef =
        FirebaseDatabase.instance.reference().child('tag_last_location');

    var probeMap = await fetchProbeLocation();

    yield* tagLastLocationRef.child(deviceId).onValue.map((event) {
      // var locationMap = event.snapshot.value;
      return DeviceLocation.fromMap(event.snapshot.value, probeMap);
    });
  }
}
