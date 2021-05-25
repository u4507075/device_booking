class UserData {
  String firstname = 'User';
  String lastname;
  String phoneNumber;
  String role;
  String email;
  String photoURL;
  String uid;
  // bool inAction;
  // String lastDeviceId;
  // DateTime lastUseTime;

  UserData({
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.role,
    this.email,
    this.photoURL,
    this.uid,
    // this.inAction,
    // this.lastDeviceId,
    // this.lastUseTime,
  });

  factory UserData.fromMap(Map map) {
    return UserData(
      firstname: map['firstname'] ?? null,
      lastname: map['lastname'] ?? null,
      phoneNumber: map['phoneNumber'] ?? null,
      role: map['role'] ?? null,
      email: map['email'] ?? null,
      photoURL: map['photoURL'] ?? null,
      uid: map['uid'] ?? null,
      // inAction: map['inAction'] ?? false,
      // lastDeviceId: map['lastDeviceId'] ?? '',
      // lastUseTime: map['lastUseTime'] ?? '',
    );
  }

  factory UserData.initialValue() => UserData(
        firstname: '',
        lastname: '',
        phoneNumber: '',
        role: '',
        email: '',
        photoURL: '',
        uid: '',
      );
}
