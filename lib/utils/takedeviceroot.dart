import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/pages/bookdevice/busydevice.dart';
import 'package:device_booking/pages/bookdevice/selectlocation.dart';
import 'package:device_booking/utils/loading.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TakeDevice extends StatelessWidget {
  // String deviceId = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    // print('TakeDevice recieved deviceId: $deviceId');
    return SafeArea(
      child: GetX<DeviceController>(
          init: Get.put(DeviceController()),
          builder: (controller) {
            print('${controller.device.deviceId}');
            if (controller != null &&
                controller.device != null &&
                !controller.device.inUse) {
              return SelectLocation();
            } else if (controller != null &&
                controller.device != null &&
                controller.device.inUse) {
              return BusyDevice();
            } else {
              return DeviceNotFound();
              //redirect to device notfound dialog & have return button
              //or implement getx worker to check duration of value being null
              //TODO return to Home(), add snackbar or dialog to show device not found instead off redirect to new page
            }
          }),
    );
  }
}

class DeviceNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('device not found \nTap to back to Home',
              style: GoogleFonts.kanit(
                  fontSize: mediumTextSize, color: Colors.redAccent)),
        ),
      ),
    );
  }
}
