import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //Get users Stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}