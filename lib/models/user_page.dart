import 'dart:async';
import 'package:device_booking/firebasedb.dart';

class Userpager {
  String imagePath;
  String email;
  String firstname;
  String lastname;
  String telephone;
  String role;

  void fetchAll(StreamController<String> _ucontroller) {
    FirebaseDB()
        .fetchData('users_testpull', 'testId')
        .then((data) {
      print(data);
      this.imagePath = data['imagePath'];
      this.email = data['email'];
      this.firstname = data['firstname'];
      this.lastname = data['lastname'];
      this.telephone = data['telephone'];
      this.role = data['role'];
      _ucontroller.add('success');
    });
  }
}