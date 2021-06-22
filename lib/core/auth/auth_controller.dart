import 'package:device_booking/core/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './user.dart';
import './auth_service.dart';

class AuthController extends GetxController {
  Rxn<User> _firebaseUser = Rxn<User>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  User get user => _firebaseUser.value;

  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(AuthService().onAuthStateChanged);
  }

  void signInWithGoogle() async {
    AuthService().signInWithGoogle();
  }

  void signInAnonymously() async {
    Get.find<LoadingController>().loading();
    await AuthService().signInAnonymously();
    Get.find<LoadingController>().loaded();
  }

  void signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
