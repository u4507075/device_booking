import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/core/core.dart';
import 'package:path/path.dart';

class ImageService {
  Future<String?> uploadProfileImage(String userId, File file) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String filePath = '${appDocDir.absolute}/file-to-upload.png';
    // print(file.absolute);

    // print(newFile.absolute);

    try {
      var newFile = await changeFileNameOnly(file, 'profile');
      Reference _ref = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userId)
          .child(basename(newFile.path));

      await _ref.putFile(newFile);
      String url = await _ref.getDownloadURL();
      print('Upload success - URL: $url');
      return url;
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
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
