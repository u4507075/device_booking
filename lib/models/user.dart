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

import 'user_profile.dart';

class User {
  String firstname;
  String lastname;
  String telephone;
  String role;
  String email;
  String imagePath;
  Map<String, dynamic> profileDetail;

  User(this.firstname, this.lastname, this.telephone, this.role, this.email,
      this.imagePath);

  static User fetchAll() {
    return User(
      'patipan',
      'sitthiprawiat',
      '0982518399',
      'intern',
      'patipan120897@gmail.com',
      'https://i.pinimg.com/originals/1a/1d/7f/1a1d7fc83afe89b6ad0f01d075d210f0.png',
    );
  }

  static List<User> fetchDetail() {
    User data;
    data = fetchAll();
    // return [''];
  }
}
