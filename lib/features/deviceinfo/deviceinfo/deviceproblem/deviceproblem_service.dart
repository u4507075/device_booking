import 'package:cloud_firestore/cloud_firestore.dart';
import './deviceproblem_model.dart';

class DeviceProblemService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<int?> fetchCount(String? deviceId) async {
    try {
      QuerySnapshot problems = await _db
          .collection('devices')
          .doc(deviceId)
          .collection('deviceProblems')
          .get();
      return problems.size;
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<int?>? streamCount(String deviceId) {
    try {
      return _db
          .collection('devices')
          .doc(deviceId)
          .collection('deviceProblems')
          .snapshots()
          .map((e) => e.size);
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<List<DeviceProblem>?> fetchProblemList(String? deviceId) async {
  //   return (await _db.collection('devices').doc(deviceId).collection('deviceProblems')).;
  // }
}
