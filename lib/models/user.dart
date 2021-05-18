import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String firstname;
  String lastname;
  String phomeNumber;
  String role;
  String email;
  String photoURL;
  String uid;

  UserData(
      {this.firstname,
      this.lastname,
      this.phomeNumber,
      this.role,
      this.email,
      this.photoURL,
      this.uid});

  UserData sample() => UserData(
        firstname: 'Sample',
        lastname: '',
        phomeNumber: '',
        role: '',
        email: 'sample@elearning.cmu.ac.th',
        photoURL: '',
        uid: '',
      );
}
