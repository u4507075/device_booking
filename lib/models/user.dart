import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String firstname = 'User';
  String lastname;
  String phoneNumber;
  String role;
  String email;
  String photoURL;
  String uid;

  UserData(
      {this.firstname,
      this.lastname,
      this.phoneNumber,
      this.role,
      this.email,
      this.photoURL,
      this.uid});

  UserData sample() => UserData(
        firstname: 'Sample',
        lastname: 'Sample',
        phoneNumber: '0981234567',
        role: 'Intern',
        email: 'sample@elearning.cmu.ac.th',
        photoURL:
            'https://th.jobsdb.com/th-th/cms/employer/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png',
        uid: 'sdfluioASDFiosdfadsf',
      );
}

//   String firstname;
//   String lastname;
//   String phomeNumber;
//   String role;
//   String email;
//   String photoURL;
//   String uid;
//   String

//   UserInfo(this.firstname, this.lastname, this.telephone, this.role, this.email,
//       this.imagePath);

//   static UserInfo fetchAll() {
//     return UserInfo(
//       'patipan',
//       'sitthiprawiat',
//       '0982518399',
//       'intern',
//       'patipan120897@gmail.com',
//       'https://i.pinimg.com/originals/1a/1d/7f/1a1d7fc83afe89b6ad0f01d075d210f0.png',
//     );
//   }

//   static List<User> fetchDetail() {
//     User data;
//     data = fetchAll();
//     // return [''];
//   }
// }

// class User {
//   final String firstname;
//   final String lastname;
//   final String imagePath;
//   final String email;
//   final String telephone;
//   final String role;

//   const User({
//     this.firstname,
//     this.lastname,
//     this.imagePath,
//     this.email,
//     this.telephone,
//     this.role,
//   });

//   static List<User> fetchAll() {
//     return [
//       User('First name', 'Lastname')
//     ];
//   }
// }
