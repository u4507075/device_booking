
class UserData /*implements ReassembleHandler*/ {
// -------------------- Model -------------------- //

  String firstname;
  String lastname;
  String phoneNumber;
  String role;
  String email;
  String photoURL;
  String uid;
  bool? inUse;

  UserData({
    this.firstname = '',
    this.lastname = '',
    this.phoneNumber = '',
    this.role = '',
    this.email = '',
    this.photoURL = '',
    this.uid = '',
    this.inUse,
  });

  factory UserData.fromMap(Map map) {
    return UserData(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      role: map['role'] ?? '',
      email: map['email'] ?? '',
      photoURL: map['photoURL'] ?? '',
      uid: map['uid'] ?? '',
      inUse: map['inUse'] ?? false,
    );
  }

  factory UserData.developer() {
    return UserData(
      firstname: 'Admin',
      lastname: 'Admin',
      phoneNumber: '+66999999999',
      role: 'Admin',
      email: 'admin@gmail.com',
      photoURL: '',
      uid: 'admin',
      inUse: false,
    );
  }

  set setfirstName(String firstName) {
    this.firstname = firstName;
  }

  set setlastName(String lastName) {
    this.lastname = lastName;
  }

  set setphoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  // static void isCompleted(){

  // }

  // factory UserData.initialValue() => UserData(
  //       firstname: null,
  //       lastname: null,
  //       phoneNumber: null,
  //       role: null,
  //       email: null,
  //       photoURL: null,
  //       uid: null,
  //       inUse: false,
  //     );

  // bool isCompleted(UserData user) {
  //   if (user.firstname != null ||
  //       user.lastname != null ||
  //       user.phoneNumber != null ||
  //       user.role != null) {
  //     if (user.firstname.length < 2 ||
  //         user.lastname.length < 2 ||
  //         user.phoneNumber.length < 10 ||
  //         user.role.length < 3) {
  //       print("Incompleted user data");
  //       return false;
  //     } else {
  //       print('Completed user data');
  //       return true;
  //     }
  //   } else {
  //     print("Data not found");
  //     return false;
  //   }
  // }

  // bool isCompleted() {
  //   String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  //   RegExp regExp = new RegExp(patttern);
  //   return !((firstname.length < 2) ||
  //       (lastname.length < 2) ||
  //       (!regExp.hasMatch(phoneNumber)) ||
  //       (role == ''));
  // }

  bool get isCompleted {
    String patttern = r'\+?[0-9]{10,11}';
    RegExp regExp = new RegExp(patttern);
    print('Check user ${this.phoneNumber}');
    return !((this.firstname.length < 2) ||
        (this.lastname.length < 2) ||
        !(regExp.hasMatch(phoneNumber)) ||
        (role == ''));
    // return true;
  }

  // bool get isCompleted {
  //   String patttern = r'\+?[0-9]{10,11}';
  //   RegExp regExp = new RegExp(patttern);
  //   print('Check user');
  //   (this.firstname.length<2)?print('firstname incompleted'):

  //   return !((this.firstname.length < 2) ||
  //       (this.lastname.length < 2) ||
  //       (regExp.hasMatch(phoneNumber)) ||
  //       (role == ''));
  // }

//user InUse
  void userInUse() {
    inUse = true;
  }

//user return
  void userReturn() {
    inUse = false;
  }

// -------------------- Repository -------------------- //

// //register new user
//   Future<void> registerNewUser({@required UserData user}) async {
//     await DBService().registerNewUser(user);
//     firstname = user.firstname;
//     lastname = user.lastname;
//     phoneNumber = user.phoneNumber;
//     role = user.role;
//     email = user.email;
//     photoURL = user.photoURL;
//     uid = user.uid;
//     inUse = false;
//   }

// //update user
//   Future<void> updateUser({@required UserData user}) async {
//     await DBService().updateUser(user);
//     firstname = user.firstname;
//     lastname = user.lastname;
//     role = user.role;
//     photoURL = user.photoURL;
//   }

// //fetch user
//   Future<UserData> fetchUser({@required String userId}) async {
//     try {
//       UserData user = await DBService().fetchUser(userId);
//       // print(user.firstname);
//       firstname = user?.firstname;
//       lastname = user?.lastname;
//       phoneNumber = user?.phoneNumber;
//       role = user?.role;
//       email = user?.email;
//       photoURL = user?.photoURL;
//       uid = user?.uid;
//       inUse = false;
//       return user;
//     } catch (e) {
//       print('user not found, ${e.toString()}');
//       return null;
//     }
//   }

  // Future<Device> lastUseDevice({@required String userId}) async {
  //   return DBService().lastUseDevice(userId);
  // }

// class Userlog {
//   String userId;
//   String deviceId;
//   bool take;
//   DateTime time;

//   Userlog({this.userId, this.deviceId, this.take, this.time});
// }

}

class UserLog {
  String deviceId;
  DateTime? time;
  String logId;
  bool? take;
  String userId;

  UserLog(
      {this.deviceId = '',
      this.logId = '',
      this.take,
      this.time,
      this.userId = ''});

  factory UserLog.fromMap(Map map) {
    return UserLog(
      deviceId: map['deviceId'] ?? '',
      logId: map['logId'] ?? '',
      take: map['take'] ?? false,
      time: DateTime.tryParse(map['time']?.toDate()?.toString() ?? ''),
      userId: map['uid'] ?? '',
    );
  }
}
