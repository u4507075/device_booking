import 'package:cloud_firestore/cloud_firestore.dart';
import './device_model.dart';
import 'package:device_booking/core/auth/user_service.dart';
import 'package:device_booking/core/auth/user.dart';
// import 'package:device_booking/core/';

class DeviceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Future<Device?> fetchDevice(String? deviceId) async {
    try {
      CollectionReference devices =
          FirebaseFirestore.instance.collection('devices');
      DocumentSnapshot documentSnapshot = await devices.doc(deviceId).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> device =
            documentSnapshot.data() as Map<String, dynamic>;
        print(
            'Retrieve device info successful: ${device['name']}, ${device['deviceType']}');
        print(device['lastUseTime']?.toDate().toString());
        return Device.fromMap(device);
      } else {
        print('Failed to retrieve device info');
        return null;
      }
    } catch (e) {}
    print('Failed to retrieve device info');
    return null;
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
    //TODO may consider to change userId to Provider<UserData> in the future to lower read&write
    //update device inUse, deviceLogs, UserLogs

    CollectionReference users = _db.collection('users');
    CollectionReference devices = _db.collection('devices');
    CollectionReference deviceLogs =
        devices.doc(device.deviceId).collection('deviceLogs');
    Timestamp now = Timestamp.fromDate(DateTime.now());

    try {
      //fetch userData to
      UserData userData =
          await (UserDataService().fetchUser(user.uid) as Future<UserData>);
      //update device inUse
      devices.doc(device.deviceId).update({
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
        'deviceId': device.deviceId,
        'logId': docRef.id,
        'userId': userData.uid,
        'take': true,
        'useTime': now,
      });

      //add userLog
      users.doc(userData.uid).collection('userLogs').doc(docRef.id).set({
        'uid': userData.uid,
        'deviceId': device.deviceId,
        'take': true,
        'logId': docRef.id,
        'time': now,
      });

      //switch user inUse status
      users.doc(userData.uid).update({'inUse': true});
      // userData.userInUse(); //TODO add this to controller instead

      print('Device - takeDevice() successful');
    } catch (e) {
      print('Device - takeDevice() unsuccessful: return error ${e.toString()}');
    }
  }

  //

  Future<void> returnDevice(Device device, UserData user) async {
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
      (device.lastUserId == user.uid)
          ? docRef.set({
              'deviceId': device.deviceId,
              'logId': docRef.id,
              'userId': user.uid,
              'take': false, //return
              'useTime': now,
              'forceReturn': false,
            })
          : docRef.set({
              'deviceId': device.deviceId,
              'logId': docRef.id,
              'userId': user.uid,
              'take': false, //return
              'useTime': now,
              'forceReturn': true, //force return by other user
            });

      //add userLog
      users.doc(user.uid).collection('userLogs').doc(docRef.id).set({
        'uid': user.uid,
        'deviceId': device.deviceId,
        'take': false, //return
        'logId': docRef.id,
        'time': now,
      });

      //switch user inUse status
      users.doc(user.uid).update({'inUse': false});
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
}
