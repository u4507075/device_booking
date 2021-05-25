import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_booking/models/user.dart';

class AuthService {
  //convert FirebaseUser to custom UserData model
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserData userDataFromFirebaseUser(User user) {
    if (user != null) {
      return UserData(
          firstname: capitalize(user.displayName.split(' ')[0]),
          lastname: capitalize(user.displayName.split(' ')[1]),
          email: user.email != null ? user.email : '',
          phoneNumber: user.phoneNumber != null ? user.phoneNumber : '',
          photoURL: user.photoURL != null ? user.photoURL : '',
          uid: user.uid != null ? user.uid : '');
    } else {
      return null;
    }
  }

  Future<UserData> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount googleUser =
          await GoogleSignIn().signIn().catchError((e) {
        print('Sign in error: ${e.toString()}');
      });

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential user = await _auth.signInWithCredential(credential);

      // print(user);
      // print('login success');
      return userDataFromFirebaseUser(user.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //listen for sign in status
  Stream<User> get onAuthStateChanged => _auth.authStateChanges();

  Stream<UserData> get onAuthStateChangedUserData =>
      _auth.authStateChanges().map(userDataFromFirebaseUser);

  //log out - google account
  Future<void> logOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    _auth.signOut();
  }
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1).toLowerCase();
}
