import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/features/deviceinfo/qrscan/qrscan.dart';
import 'package:device_booking/core/core.dart';
import './devicelist_controller.dart';

class DeviceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Device> devices;
    final String deviceType = Get.arguments.toString();
    DeviceListController controller = Get.put(DeviceListController(deviceType));
    // devices = Get.find<DeviceListController>().list;
    // print(deviceType);

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
                  if (controller != null && controller.list != null) {
                    print('${controller.list}');
                    devices = controller.list;
                    return ListView.builder(
                      padding: EdgeInsets.all(5.0),
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        // print(devices[index]);
                        return _deviceInfo(devices[index]);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: qrScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}

Widget _deviceInfo(Device device) {
  String assetPath;
  if (device.deviceType == 'ultrasound') {
    assetPath = "assets/images/ultrasonography.png";
  } else if (device.deviceType == 'ekg') {
    assetPath = "assets/images/electrocardiogram.png";
  } else {
    assetPath = '';
  }

  Color _color;

  (device.maintenance)
      ? _color = Colors.yellow
      : (device.inUse)
          ? _color = Colors.red
          : _color = Colors.green;

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 1.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Row(
        children: [
          Flexible(
            flex: 10,
            child: ListTile(
              onTap: () {
                Get.find<DeviceController>().setDevice(device);
                Get.toNamed('/deviceinfo');
              },
              title: Text(device.name ?? ''),
              subtitle: Text(device.location ?? ''),
              leading: Image.asset(
                assetPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              decoration: BoxDecoration(color: _color),
            ),
          ),
        ],
      ),
    ),
  );
}
