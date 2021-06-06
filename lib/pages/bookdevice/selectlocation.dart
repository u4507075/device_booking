import 'dart:async';
import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/pages/bookdevice/confirmation.dart';
import 'package:device_booking/pages/bookdevice/qrscan.dart';
import 'package:get/get.dart';

class SelectLocation extends StatelessWidget {
  // const SelectLocation({Key key}) : super(key: key);
  List<dynamic> operatingZone =
      Get.find<DeviceController>().device?.operatingZone;
  @override
  Widget build(BuildContext context) {
    print('${Get.find<DeviceController>().device?.operatingZone}');
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        title: Text('Select location'),
      ),
      body: ListView.builder(
        itemCount: Get.find<DeviceController>().device.operatingZone.length,
        itemBuilder: (context, index) {
          return _location(operatingZone[index]);
        },
      ),
    );
  }
}

Widget _location(String location) {
  return ListTile(
    title: Text('$location'),
    onTap: () {
      Get.toNamed('/confirmation', parameters: {
        'deviceId': Get.find<DeviceController>().device.deviceId,
        'location': location,
      });
    },
  );
}
