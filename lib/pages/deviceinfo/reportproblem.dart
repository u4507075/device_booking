import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/pages/pages.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/services/database.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ReportProblem extends StatelessWidget {
  // ReportProblemPage Reportproblem = ReportProblemPage();
  // StreamController<String> _controller = StreamController.broadcast();

  // UserController controller = Get.find<UserController>();
  String deviceId = Get.arguments.toString();
  String userId = Get.find<UserController>().user.uid;
  TextEditingController textFieldController = TextEditingController();

  // ReportProblem({this.deviceId});

  void _updateData(
          {@required String deviceId,
          @required String userId,
          @required String reportText}) async =>
      DBService().reportDevice(deviceId, userId, reportText);

  @override
  Widget build(BuildContext context) {
    print('$deviceId');
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: Text(
          'Report Problem',
          style: appBarTextStyle,
        ),
        actions: [
          TextButton(
              onPressed: () {
                String reportText = textFieldController.text;
                if (textFieldController.text.length != 0) {
                  print('Problem submitted');
                  _updateData(
                      deviceId: deviceId,
                      userId: userId,
                      reportText: reportText);
                  Get.back();
                } else {
                  print("Text length can't be 0");
                }
              },
              child: Text('Submit', style: appBarTextStyle))
        ],
      ),
      body: _myCustomForm(),
    );
  }

  Widget _myCustomForm() {
    // ReportProblemPage Reportproblem = ReportProblemPage();

    // StreamController<String> _controller = StreamController.broadcast();

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: textFieldController,
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: 30,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter here',
                ),
              ),
            ]),
      ),
    );
  }
}

//   void updateDa{ta() {
//     String time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//     const _chars =
//         'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//     Random _rnd = Random();
//     String getRandomString(int length) =>
//         String.fromCharCodes(Iterable.generate(
//             length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
//     String documentID = (getRandomString(20));
//     try {
//       databaseReference
//           .collection('devices')
//           .doc(DeviceID)
//           .collection('deviceProblems')
//           .doc('$documentID')
//           .set({
//         'datetime': "$time",
//         'problem': TextFieldController.text,
//         'uid': 'UserID'
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
