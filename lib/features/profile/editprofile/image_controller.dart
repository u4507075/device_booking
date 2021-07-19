import 'dart:io';
import 'package:device_booking/core/core.dart';
import 'package:device_booking/features/profile/editprofile/image_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var _image = Rxn<XFile>();

  File? get file => _image.value != null ? File(_image.value!.path) : null;

  set image(XFile? xFile) {
    _image.value = xFile;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  void clear() {
    _image.value = null;
  }

  Future<String?>? uploadProfileImage() {
    return this.file != null
        ? ImageService().uploadProfileImage(
            Get.find<AuthController>().firebaseUser!.uid, this.file!)
        : null;
  }
}
