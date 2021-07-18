import 'dart:typed_data';
import 'dart:ui';
import 'package:device_booking/core/device/device_service.dart';
import 'package:device_booking/features/deviceinfo/devicelist/devicelist_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/features/features.dart';
import 'package:device_booking/core/core.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import './devicelist_controller.dart';
import 'package:styled_widget/styled_widget.dart';

class DeviceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Device>? devices;
    final String deviceType = Get.arguments.toString();
    var controller = Get.put(DeviceListController(deviceType));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Device Location')
            .textStyle(Theme.of(context).textTheme.bodyText1!),
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
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: GetX<DeviceListController>(
                init: Get.put(DeviceListController(deviceType)),
                builder: (controller) {
                  if (controller.list != null) {
                    print(
                        'Numbers of $deviceType device found: ${controller.list?.length}');
                    devices = controller.list;
                    return ListView.builder(
                      padding: EdgeInsets.all(5.0),
                      itemCount: devices!.length,
                      itemBuilder: (context, index) {
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
  //Todo remove this hard code -> fetch URL from Firebase Storage instead
  String assetPath = 'assets/images/' + device.deviceType! + '.png';
  // if (device.deviceType == 'ultrasound') {
  //   assetPath = "assets/images/ultrasonography.png";
  // } else if (device.deviceType == 'ekg') {
  //   assetPath = "assets/images/electrocardiogram.png";
  // } else {
  //   assetPath = '';
  // }

  Color _color;

  device.maintenance!
      ? _color = Colors.yellow[900]!
      : device.inUse!
          ? _color = Colors.red
          : _color = Colors.green;

  print(assetPath);

  return StreamBuilder(
    stream: Stream.periodic(Duration(milliseconds: 60000)),
    // initialData: initialData,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return StreamBuilder(
          stream: Get.find<DeviceController>().streamProbeLocation(),
          initialData: {},
          builder: (context, probeSnapshot) {
            return StreamBuilder(
                stream:
                    Get.find<DeviceController>().streamDeviceLocation(device),
                initialData: DeviceLocation(),
                builder: (context, locationSnapshot) {
                  return FutureBuilder(
                      future:
                          DeviceListService().fetchImage(device.deviceType!),
                      builder: (context, imageSnapshot) {
                        var deviceLocation =
                            locationSnapshot.data as DeviceLocation?;
                        var probeMap = probeSnapshot.data as Map;
                        var location = probeMap[deviceLocation?.locationId];
                        var timeLapsed = _timeFormat(deviceLocation?.time);
                        var image = imageSnapshot.data as Uint8List?;

                        return StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            bool pressed = false;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Card(
                                shadowColor: Colors.grey[100]!.withAlpha(100),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                elevation: 10.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Material(
                                    child: InkWell(
                                      onFocusChange: (value) => print(value),
                                      onTap: () {
                                        Get.find<DeviceController>()
                                            .setDevice(device);
                                        Get.toNamed('/deviceinfo');
                                        //  Navigator.push(context, PageRouteBuilder(
                                        //    transitionDuration: Duration(seconds: 2),
                                        //    pageBuilder: (_,__,___)=>DeviceInfo()));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 20,
                                              child: ListTile(
                                                isThreeLine: true,
                                                leading: Column(
                                                  children: [
                                                    Flexible(
                                                      flex: 2,
                                                      child: Image.asset(
                                                        assetPath,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      // child: image != null
                                                      //     ? Image.memory(
                                                      //         image,
                                                      //         fit: BoxFit.cover,
                                                      //       )
                                                      //     : DecoratedBox(
                                                      //         decoration:
                                                      //             BoxDecoration(
                                                      //                 color: Colors
                                                      //                     .white)),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5.0),
                                                        child: Text(
                                                          'RSSI: ${deviceLocation?.rssi ?? '-'}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          9),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                title: Text(
                                                  '${device.deviceType?.toString().capitalize} ${device.name}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${location ?? 'Unknown'}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                    ),
                                                    Text(
                                                      'Last seen: $timeLapsed',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                            color: Colors
                                                                .grey[600],
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
                                                decoration: BoxDecoration(
                                                    color: _color),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      });
                });
          });
    },
  );
}

String _timeFormat(DateTime? time) {
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
