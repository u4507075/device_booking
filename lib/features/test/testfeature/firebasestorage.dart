import 'package:device_booking/core/device/device_service.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageTest extends StatefulWidget {
  const FirebaseStorageTest({Key? key}) : super(key: key);

  @override
  _FirebaseStorageTestState createState() => _FirebaseStorageTestState();
}

class _FirebaseStorageTestState extends State<FirebaseStorageTest> {
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new device'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
                'https://firebasestorage.googleapis.com/v0/b/med-cmu-device-tracking-system.appspot.com/o/device.png?alt=media&token=ced22fa4-0eee-420d-9458-aaeba56626aa'),
            // Text('Add new device'),
            ElevatedButton(
              onPressed: () async {
                Reference ref = storage.ref('device.png');
                String url = await ref.getDownloadURL();
                print(ref.toString());
                print(url);
              },
              child: Text('Test Storage'),
            )
          ],
        ),
      ),
    );
  }
}
