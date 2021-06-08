import 'package:device_booking/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();
  // Rxn<UserData> _userData = Rxn<UserData>();

  User get firebaseUser => _firebaseUser.value;
  // UserData get userData => _userData.value;

  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(AuthService().onAuthStateChanged);
  }

  void signinWithGoogle() async {
    AuthService().signInWithGoogle();
  }

  void signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // void createUser(String name, String email, String password) async {
  //   try {
  //     AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
  //         email: email.trim(), password: password);
  //     //create user in database.dart
  //     UserModel _user = UserModel(
  //       id: _authResult.user.uid,
  //       name: name,
  //       email: _authResult.user.email,
  //     );
  //     if (await Database().createNewUser(_user)) {
  //       Get.find<UserController>().user = _user;
  //       Get.back();
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error creating Account",
  //       e.message,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  // void login(String email, String password) async {
  //   try {
  //     AuthResult _authResult = await _auth.signInWithEmailAndPassword(
  //         email: email.trim(), password: password);
  //     Get.find<UserController>().user =
  //         await Database().getUser(_authResult.user.uid);
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error signing in",
  //       e.message,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

}
