import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import './takedevice.dart';

class TakeDeviceRoot extends StatelessWidget {
  // String deviceId = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    // print('TakeDevice recieved deviceId: $deviceId');
    return SafeArea(
      child: GetX<DeviceController>(
          init: Get.put(DeviceController()),
          builder: (controller) {
            print('${controller.device?.deviceId}');
            return (controller.device != null)
                ? (controller.device!.inUse ?? false)
                    ? BusyDevice()
                    : SelectLocation() //Todo switch back!
                : DeviceNotFound();

            // if (controller.device != null && !controller.device?.inUse? ?? false != true) {
            //   return SelectLocation();
            // } else if (controller.device != null && controller.device?.inUse) {
            //   return BusyDevice();
            // } else {
            //   return DeviceNotFound();
            //   //redirect to device notfound dialog & have return button
            //   //or implement getx worker to check duration of value being null
            //   //TODO return to Home(), add snackbar or dialog to show device not found instead off redirect to new page
            // }
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
              style: Get.theme.textTheme.headline6),
        ),
      ),
    );
  }
}
