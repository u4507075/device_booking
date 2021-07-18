import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/core/core.dart';

class ImageService {
  Future<void> uploadProfileImage(UserData user, File file) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String filePath = '${appDocDir.absolute}/file-to-upload.png';
    // print(file.absolute);
    print(file.absolute);
    var newfile = await changeFileNameOnly(file, 'imagetest');
    print(newfile.absolute);

    // try {
    //   await FirebaseStorage.instance.ref().child('users').putFile(file);
    // } on FirebaseException catch (e) {
    //   print(e.toString());
    // }
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    String fileExtension = '.' + path.split('.')[path.split('.').length - 1];
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath =
        path.substring(0, lastSeparator + 1) + newFileName + fileExtension;
    return file.rename(newPath);
  }
}
