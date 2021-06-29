import 'package:get/get.dart';

class PhoneAuthController extends GetxController {
  var _smsCode = ''.obs;
  var _verificationId = ''.obs;
  var _phoneNumber = ''.obs;

  String get smsCode => _smsCode.value;
  String get verificationId => _verificationId.value;
  String get phoneNumber => _phoneNumber.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  void saveCode(String code) {
    _smsCode.value = code;
  }

  void saveVerificationId(String verificationId) {
    _verificationId.value = verificationId;
  }

  void savePhoneNumber(String phoneNumber) {
    _phoneNumber.value = phoneNumber;
  }

  void clear() {
    _smsCode.value = '';
    _verificationId.value = '';
  }
}
