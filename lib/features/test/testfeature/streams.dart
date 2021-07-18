import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';
import 'package:get/get.dart';
// import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stream_transform/stream_transform.dart';

class StreamsTest extends StatefulWidget {
  // const StreamsTest({Key? key}) : super(key: key);

  @override
  _StreamsTestState createState() => _StreamsTestState();
}

class _StreamsTestState extends State<StreamsTest> {
  UserController userController = Get.find<UserController>();

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Streams Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder(
              stream: _streamProbeLocation(),
              initialData: {},
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text(snapshot.data.toString());
              },
            ),

            //? This method still have latency ~ 10s - 20s -> Unusable
            StreamBuilder(
              stream: _combineStream('fxBWBPFJUMEi4qD6Xlw6'),
              initialData: DeviceLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text((snapshot.data).locationId.toString());
              },
            ),
            //? this method use Future inside Stream -> few latency ->
            StreamBuilder(
              stream: depender('fxBWBPFJUMEi4qD6Xlw6'),
              initialData: DeviceLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data.locationId);
                return Text((snapshot.data).location.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}

final FirebaseFirestore _db = FirebaseFirestore.instance;
//Implement on innit
Future<Map<String, dynamic>> _fetchProbeLocation() async {
  try {
    var _map =
        (await _db.collection('utils').doc('probeLocation').get()).data();
    return _map ?? {};
  } catch (e) {
    return {};
  }
}

Stream<Map<String, dynamic>> _streamProbeLocation() {
  return _fetchProbeLocation().asStream();
}

// Stream<DeviceLocation>? _streamLastDeviceLocation(String deviceId) {
//   var tagLastLocationRef =
//       FirebaseDatabase.instance.reference().child('tag_last_location');
//   try {
//     return tagLastLocationRef
//         .child(deviceId)
//         .onValue
//         .map((map) => DeviceLocation.fromMap(map.snapshot.value));
//   } catch (e) {
//     return null;
//   }
// }

Stream<DeviceLocation>? _combineStream(String deviceId) {
  var tagLastLocationRef =
      FirebaseDatabase.instance.reference().child('tag_last_location');

  return tagLastLocationRef
      .child(deviceId)
      .onValue
      .withLatestFrom<Map<String, dynamic>, DeviceLocation>(
          _streamProbeLocation(), (event, probeMap) {
    print(event.toString() + probeMap.toString());
    var locationMap = event.snapshot.value;
    return DeviceLocation(
        locationId: locationMap['location_id'] ?? 'Not found');
  });
}
// final probeMapStream = _streamProbeLocation();
// final deviceLocationStream = probeMapStream.asyncMap((event) => null)

Stream<DeviceLocation>? depender(String deviceId) async* {
  var tagLastLocationRef =
      FirebaseDatabase.instance.reference().child('tag_last_location');

  var probeMap = await _fetchProbeLocation();

  yield* tagLastLocationRef.child(deviceId).onValue.map((event) {
    var locationMap = event.snapshot.value;
    var locationId = locationMap['location_id'];
    return DeviceLocation(
        locationId: locationId ?? 'Not found',
        location: probeMap[locationId ?? '']);
  });
}
