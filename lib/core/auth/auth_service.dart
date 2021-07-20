import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_phone_controller.dart';
import 'package:device_booking/core/utils/utils.dart';
import 'user_service.dart';
import 'user.dart';

class AuthService {
  //convert FirebaseUser to custom UserData model
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserData? userDataFromFirebaseUser(User? user) {
    if (user != null) {
      return UserData(
        firstname: user.displayName?.split(' ')[0].capitalize ?? '',
        lastname: ((user.displayName?.split(' ') ?? []).length > 2)
            ? user.displayName?.split(' ')[1].capitalize ?? ''
            : '',
        email: user.email ?? '',
        phoneNumber: user.phoneNumber ?? '',
        photoURL: user.photoURL ?? '',
        uid: user.uid,
      );
    } else {}
  }

  Future<UserData?> signInAnonymously() async {
    UserCredential user = await FirebaseAuth.instance.signInAnonymously();
    return userDataFromFirebaseUser(user.user);
  }

  Future<UserData?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential user = await _auth.signInWithCredential(credential);

      UserData? userData = await UserDataService().fetchUser(user.user?.uid);
      if (userData != null) {
        //already has UserData in Firestore
        return userData;
      } else {
        // UserData().registerNewUser(
        //     user: userDataFromFirebaseUser(user.user)); //New user
        return userDataFromFirebaseUser(user.user);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserData?> signInWithPhoneNumber(
      PhoneAuthCredential credential) async {
    try {
      UserCredential user = await _auth.signInWithCredential(credential);
      UserData? userData = await UserDataService().fetchUser(user.user?.uid);
      if (userData != null) {
        //already has UserData in Firestore
        return userData;
      } else {
        // UserData().registerNewUser(
        //     user: userDataFromFirebaseUser(user.user)); //New user
        return userDataFromFirebaseUser(user.user);
      }
    } on FirebaseAuthException catch (e) {
      //? show notification to user -> why sign in fail?
      Get.snackbar('MedTrack', e.message ?? '',
          backgroundColor: Get.theme.canvasColor.withOpacity(0.6));

      //? return to main authentication page
      Get.back();
    } catch (e) {
      print('[Sign in with phone number]: ' + e.toString());
      //? return to main authentication page -> why sign in fail?
      Get.snackbar('MedTrack', e.toString(),
          backgroundColor: Get.theme.canvasColor.withOpacity(0.6));
      //? return to main authentication page
      Get.back();
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+66' + phoneNumber.substring(phoneNumber.length - 9),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        //! Disable Android Auto retrieve OTP
        // await _auth.signInWithCredential(credential);
        // Get.back();
      },
      verificationFailed: (FirebaseAuthException e) async {
        print('verification failed, ${e.toString()}');
        Get.snackbar('MedTrack', e.toString());
        Get.find<LoadingController>().loaded();
        // Get.back();

        // Get.snackbar('Log In Failed', '${e.code.toString()}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        Get.find<LoadingController>().loaded();
        Get.find<PhoneAuthController>().saveVerificationId(verificationId);
        print('Code sent to: $phoneNumber');
        Get.toNamed('/getotp');
        // (Platform.isAndroid) ? Get.toNamed('/signup') : Get.toNamed('/getotp');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Get.snackbar('Time out', 'No sms confirm within 60 seconds');
        Get.find<PhoneAuthController>().clear();
      },
    );
  }

  Future signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      // await googleSignIn.disconnect();
      await _auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //listen for sign in status
  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  Stream<UserData?> get onAuthStateChangedUserData =>
      _auth.authStateChanges().map(userDataFromFirebaseUser);

  //log out - google account
  Future<void> logOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    _auth.signOut();
  }

//   Future<void> signInWithPhone() async {
// //verify phone number
//     await _auth.verifyPhoneNumber(
//       phoneNumber: '+44 7123 123 456',
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {},
//       codeSent: (String verificationId, int resendToken) {},
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
}
