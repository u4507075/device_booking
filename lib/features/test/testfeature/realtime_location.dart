import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/core/device/device_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';

class RealtimeDatabaseTest extends StatefulWidget {
  const RealtimeDatabaseTest({Key? key}) : super(key: key);

  @override
  _RealtimeDatabaseTestState createState() => _RealtimeDatabaseTestState();
}

class _RealtimeDatabaseTestState extends State<RealtimeDatabaseTest> {
  var deviceController = Get.put(DeviceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('data'),
            StreamBuilder(
              stream: TestService().streamLastLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text('${snapshot.data?.snapshot.value}');
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // TestService().getDict().then((value) => setState(() {}));
                DeviceService().streamLastDeviceLocation('');
              },
              child: Text('refresh'),
            )
          ],
        ),
      ),
    );
  }
}

class TestService {
  var probeRef = FirebaseDatabase.instance.reference().child('probe_location');

  var tagRef = FirebaseDatabase.instance.reference().child('tag');

  var tagLastLocationRef =
      FirebaseDatabase.instance.reference().child('tag_last_location');

  // Future<void> getDict() async {
  //   return tagLastLocationRef.get().then((snapshot) {
  //     print(snapshot!.value);
  //     return snapshot.value;
  //   });
  // }

  Stream<Event> streamLastLocation() {
    return tagLastLocationRef.child('ca:94:5b:43:9f:22').onValue;
  }

  // Future<DocumentSnapshot> fetchLastLocation() {
  //   return tagLastLocationRef.get().then((snapshot) {
  //     print(snapshot!.value);
  //     return snapshot.value;
  //   });
  // }
}
