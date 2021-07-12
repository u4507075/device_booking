import 'dart:typed_data';
import 'dart:ui';

import 'package:device_booking/core/device/device_service.dart';
import 'package:device_booking/features/deviceinfo/deviceinfo/devicecomment.dart';
import 'package:device_booking/features/deviceinfo/deviceinfo/devicecomment_model.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_booking/core/core.dart';

import 'package:device_booking/features/features.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class DeviceInfo extends StatelessWidget {
  String? _text;
  void unFocus() {
    return FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    DeviceController deviceController = Get.put(DeviceController());
    // Get.find<DeviceController>().bindingStream();

    // Widget _reportButton() => Container(
    //       margin: EdgeInsets.all(10.0),
    //       child: Align(
    //         alignment: Alignment.bottomRight,
    //         child: ElevatedButton(
    //           onPressed: () {
    //             Get.toNamed('/reportproblem',
    //                 arguments: deviceController.device!.deviceId);
    //           },
    //           child: Text('Report'),
    //           style: ElevatedButton.styleFrom(
    //               primary: Colors.amber, onPrimary: Colors.black),
    //         ),
    //       ),
    //     );

    var children = [
      Obx(() => Text(
          '${deviceController.device?.deviceType?.capitalize ?? ''}\n${deviceController.device?.name?.capitalize ?? ''}',
          style: Theme.of(context).textTheme.headline1)),
      SizedBox(
        height: 20.0,
      ),
      Text(
        'Status',
        style: Theme.of(context).textTheme.headline3,
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Obx(
          () {
            Color _color;

            deviceController.device!.maintenance!
                ? _color = Colors.yellow
                : deviceController.device!.inUse!
                    ? _color = Colors.red
                    : _color = Colors.green;
            return Text(
              '${!deviceController.device!.inUse! ? 'Available' : 'Busy'}', //TODO: add color
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: _color),
            );
          },
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        'Last use',
        style: Theme.of(context).textTheme.headline3,
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Obx(
          () => Text(
            '${deviceController.device!.location}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),

      SizedBox(
        height: 20.0,
      ),
      Text(
        'Last seen',
        style: Theme.of(context).textTheme.headline3,
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: StreamBuilder(
          //todo not utilize deviceservice directly
          stream: DeviceService().streamLastDeviceLocation(
              deviceController.device?.locatorId ?? ''),
          initialData: DeviceLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text(snapshot.data?.location ?? 'Unknown');
          },
        ),
      ),

      SizedBox(
        height: 20.0,
      ),
      Text('Last use', style: Theme.of(context).textTheme.headline3),
      Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
        child: Table(
          columnWidths: {0: FractionColumnWidth(0.25)},
          border: TableBorder(
              horizontalInside:
                  BorderSide(width: 1.0, color: Colors.grey[400]!)),
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('User',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(() => Text('${deviceController.device!.lastUser}',
                      style: Theme.of(context).textTheme.bodyText2)),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Tel.',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () {
                            String? phoneNumber;

                            (deviceController.device?.lastUserPhoneNumber !=
                                    null)
                                ? (deviceController.device!.lastUserPhoneNumber!
                                            .length >
                                        9)
                                    ? phoneNumber = formatPhoneNumber(
                                        deviceController
                                            .device!.lastUserPhoneNumber!)
                                    : phoneNumber = ''
                                : phoneNumber = '';

                            return Text('$phoneNumber',
                                style: Theme.of(context).textTheme.bodyText2);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          height: 20,
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              print(
                                  deviceController.device?.lastUserPhoneNumber);
                              (deviceController.device?.lastUserPhoneNumber !=
                                      '')
                                  ? launch(
                                      'tel:${deviceController.device?.lastUserPhoneNumber}')
                                  : null;
                            },
                            icon: Icon(
                              Icons.phone,
                              // size: mediumTextSize,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Date',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                      () => Text(
                          '${deviceController.device!.lastUseTime != null ? DateFormat('E, d/MM/yyyy').format(deviceController.device!.lastUseTime!) : ''}',
                          style: Theme.of(context).textTheme.bodyText2),
                    )),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Time',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                      () => Text(
                          '${deviceController.device!.lastUseTime != null ? DateFormat('HH:mm').format(deviceController.device!.lastUseTime!) : ''}',
                          style: Theme.of(context).textTheme.bodyText2),
                    )),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        'Comments',
        style: Theme.of(context).textTheme.headline3,
      ),
      addComment(), //todo display only not anonymous user
      // commentSection(
      //   DeviceComment(
      //       displayName: 'Patipan Sitthiprawiat',
      //       comment:
      //           'This is a sample comment, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel odio quis turpis commodo placerat. Sed mattis lobortis dolor, vel euismod lectus elementum sed. Donec a dui porta orci fringilla mollis. Nulla fermentum finibus erat a consequat. Fusce sagittis accumsan.',
      //       time: DateTime.now()),
      // ),
      commentList(),
      Center(child: seeMoreComment()),
      Column(
        children: [
          Container(
            // height: 500,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 100.0, //todo do as in sign up page - single scroll view
      )
    ];

    // final qrCode = QrCode.fromData(
    //     data: deviceController.device?.deviceId ?? '',
    //     errorCorrectLevel: QrErrorCorrectLevel.L);

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => unFocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(color: Colors.grey),
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.times, size: 30.0),
                          color: Colors.grey[400],
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton(
                          // onPressed: () {
                          //   return PopupMenuItem(
                          //     // value: ,
                          //     child: Text('Working a lot harder'),
                          //   );
                          // },
                          onSelected: (value) {
                            Get.defaultDialog(
                              title: 'More Device Info.',
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      'DeviceId: ${deviceController.device?.deviceId}'),
                                  Text(
                                      'BeaconId: ${deviceController.device?.locatorId}'),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                    child: QrImage(
                                      data: deviceController.device!.deviceId!,
                                      // version: QrVersions.auto,
                                      // size: 200.0,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        Get.back();
                                        (await saveQrToGallery(deviceController
                                                    .device!.deviceId!) ??
                                                false)
                                            ? Get.snackbar(
                                                'Save an image successful',
                                                'Qr code has been save to your gallery')
                                            : Get.snackbar(
                                                'Save an image failed',
                                                'Qr An unknown error has occured');
                                      },
                                      icon: Icon(FontAwesomeIcons.download))
                                ],
                              ),
                            );
                          },
                          itemBuilder: (context) {
                            return <PopupMenuItem<String>>[
                              PopupMenuItem(
                                  value: '123123', child: Text('More info.'))
                            ];
                          },
                          icon: Icon(
                            FontAwesomeIcons.ellipsisV,
                            color: Colors.grey[400],
                          ),

                          // icon: Icon(Icons),
                        ),
                      ),
                      // _reportButton(),
                    ],
                  ), //TODO add image of the device
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: qrScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
}
