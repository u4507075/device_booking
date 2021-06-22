import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/core/core.dart';

class DeviceListService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Stream<List<Device>> streamDeviceList(String deviceType) {
    try {
      return _db
          .collection("devices")
          .where('deviceType', isEqualTo: deviceType)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return Device.fromMap(doc.data());
        }).toList();
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
