import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/user/users.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users_testpull');

  //users list from snapshot
  List<Users> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Users(
        imagePath: doc.get('imagePath') ?? 'https://www.ktnwebdesign.com/wp-content/uploads/2019/10/123456.png',
        email: doc.get('email') ?? 'unknown email',
        firstname: doc.get('firstname') ?? 'no fname',
        lastname: doc.get('lastname') ?? 'no lname',
        telephone: doc.get('telephone') ?? '0000000000',
        role: doc.get('role') ?? 'unknown',
      );
    }).toList();
  }

  //Get users Stream
  Stream<List<Users>> get users {
    return userCollection.snapshots().map(_usersListFromSnapshot);
  }
}