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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white)))
        ],
      ),
      body: _myCustomForm(),
    );
  }

  Widget _myCustomForm() {
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
