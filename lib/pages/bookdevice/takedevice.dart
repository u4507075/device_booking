import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/pages/bookdevice/selectlocation.dart';
import 'package:device_booking/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TakeDevice extends StatelessWidget {
  String deviceId = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    print('TakeDevice recieved deviceId: $deviceId');
    return SafeArea(
      child: GetX<DeviceController>(
          init: Get.put(DeviceController(deviceId)),
          builder: (controller) {
            if (controller != null &&
                controller.deviceInfo != null &&
                controller.deviceInfo.name != null) {
              return SelectLocation();
            } else {
              // Future.delayed(Duration(seconds: 5)).then((value) => Get.back());
              return DeviceNotFound();
              //redirect to device notfound dialog & have return button
              //or implement getx worker to check duration of value being null
            }
          }),
    );
  }
}

class DeviceNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device not found'),
      ),
    );
  }
}
