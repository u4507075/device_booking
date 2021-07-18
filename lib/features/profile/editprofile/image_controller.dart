import 'dart:io';

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
  }

  void clear() {
    _image.value = null;
  }
}
