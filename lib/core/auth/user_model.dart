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

//user InUse
  void userInUse() {
    inUse = true;
  }

//user return
  void userReturn() {
    inUse = false;
  }
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
