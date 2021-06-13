import 'dart:ui';
import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/controller/devicelist_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/widget/qrscanbutton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DeviceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Device> devices;
    final String deviceType = Get.arguments.toString();
    DeviceListController controller = Get.put(DeviceListController(deviceType));
    devices = Get.find<DeviceListController>().value?.devices;

    print(deviceType);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Location',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: GetX<DeviceListController>(
                init: Get.put(DeviceListController(deviceType)),
                builder: (controller) {
                  if (controller != null && controller.value != null) {
                    print('${controller.value}');
                    // return Text('Data');
                    devices = controller.value.devices;
                    return ListView.builder(
                      padding: EdgeInsets.all(5.0),
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        // print(devices[index]);
                        return _deviceInfo(devices[index]);
                      },
                    );
                  } else {
                    return Text('Loading');
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _qrScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}

Widget _qrScanButton() => qrScanButton();

Widget _deviceInfo(Device device) {
  String assetPath;
  if (device.deviceType == 'ultrasound') {
    assetPath = "assets/images/ultrasonography.png";
  } else if (device.deviceType == 'ekg') {
    assetPath = "assets/images/electrocardiogram.png";
  } else {
    assetPath = '';
  }

  return Card(
    child: ListTile(
      onTap: () {
        final String deviceId = device.deviceId;
        print('$deviceId');
        Get.find<DeviceController>().fetchDevice(deviceId);
        Get.toNamed('/deviceinfo');
      },
      title: Text(device.name ?? ''),
      subtitle: Text(device.location ?? ''),
      leading: Image.asset(
        assetPath,
        fit: BoxFit.cover,
      ),
    ),
  );
}
