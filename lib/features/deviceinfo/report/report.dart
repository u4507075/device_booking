import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';

class ReportProblem extends StatelessWidget {
  final DeviceController deviceController = Get.put(DeviceController());
  final TextEditingController textFieldController = TextEditingController();

  void _updateData(
          {required Device device,
          required UserData user,
          required String reportText}) async =>
      Get.find<DeviceController>()
          .reportDevice(device: device, user: user, reportText: reportText);

  @override
  Widget build(BuildContext context) {
    // print('$deviceId');
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
                      device: deviceController.device!,
                      user: Get.find<UserController>().user!,
                      reportText: reportText);
                  Get.back();
                } else {
                  print("Text length can't be 0");
                }
              },
              child: Text('Submit',
                  style: Theme.of(context).appBarTheme.titleTextStyle))
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
