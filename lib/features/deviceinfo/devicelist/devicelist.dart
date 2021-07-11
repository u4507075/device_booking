import 'dart:ui';
import 'package:device_booking/core/device/device_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/features/features.dart';
import 'package:device_booking/core/core.dart';
import './devicelist_controller.dart';

class DeviceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Device>? devices;
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Device Location',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.0,
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
                      itemCount: devices!.length,
                      itemBuilder: (context, index) {
                        // print(devices[index]);
                        return _deviceList(devices![index]);
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
      floatingActionButton: qrScanButtonExtended(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}

Widget _deviceList(Device device) {
  String assetPath;
  if (device.deviceType == 'ultrasound') {
    assetPath = "assets/images/ultrasonography.png";
  } else if (device.deviceType == 'ekg') {
    assetPath = "assets/images/electrocardiogram.png";
  } else {
    assetPath = '';
  }

  Color _color;

  device.maintenance!
      ? _color = Colors.yellow
      : device.inUse!
          ? _color = Colors.red
          : _color = Colors.green;

  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return StreamBuilder<DeviceLocation>(
          stream:
              DeviceService().streamLastDeviceLocation(device.locatorId ?? ''),
          initialData: DeviceLocation(),
          builder: (context, snapshot) {
            var deviceLocation = snapshot.data ?? DeviceLocation();
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 20,
                      child: ListTile(
                        onTap: () {
                          Get.find<DeviceController>().setDevice(device);
                          Get.toNamed('/deviceinfo');
                        },
                        isThreeLine: true,
                        leading: Column(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Image.asset(
                                assetPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  'RSSI: ${deviceLocation.rssi ?? '-'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 9),
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          '${device.deviceType} ${device.name}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${deviceLocation.location ?? 'Unknown'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                            Text(
                              'Last seen: ${timeFormat(deviceLocation.time)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
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
          });
    },
  );
}

String timeFormat(DateTime? time) {
  var now = DateTime.now();
  String text = '';
  if (time != null) {
    Duration timeLapsed = now.difference(time);

    timeLapsed.compareTo(Duration(minutes: 1)) < 0
        ? text = 'few seconds ago'
        : timeLapsed.compareTo(Duration(hours: 1)) < 0
            ? text = timeLapsed.inMinutes.toString() + ' minute(s) ago'
            : timeLapsed.compareTo(Duration(days: 1)) < 0
                ? text = timeLapsed.inHours.toString() + ' hour(s) ago'
                : timeLapsed.compareTo(Duration(days: 7)) < 0
                    ? text = timeLapsed.inDays.toString() + ' day(s) ago'
                    : text = timeLapsed.inDays.toString() + ' day(s) ago';
    // : timeLapsed.compareTo(Duration(days: 31)) < 0
    //     ? text = timeLapsed.in.toString() + ' week(s) ago'
    //     : text = DateFormat().format(time) + ' month(s) ago';}else{

  }

  return text;
}
