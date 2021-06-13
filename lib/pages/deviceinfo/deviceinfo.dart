import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/style.dart';
import 'package:device_booking/widget/qrscanbutton.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceInfo extends StatelessWidget {
  final String _status = 'available';
  static const TextStyle _titlestyle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  static const TextStyle _subtitlestyle =
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

  final String deviceId = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    DeviceController deviceController = Get.put(DeviceController());

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            // Obx(() => Text(
            //     '${deviceController.device.name}\n${deviceController.device.inUse}\n${deviceController.device.maintenance}\n')),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(color: Colors.grey),
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close, size: 30.0),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  _reportButton(),
                ],
              ), //TODO add image of the device
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                      '${deviceController.device?.deviceType?.capitalize ?? ''} ${deviceController.device?.name?.capitalize ?? ''}',
                      style: Theme.of(context).textTheme.headline1)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Text(
                            'Status',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            'Location',
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                            padding: EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Obx(
                              () => Text(
                                '${!deviceController.device.inUse ? 'Available' : 'Busy'}', //TODO: add color
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
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
                                '${deviceController.device.location}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Last use',
                      style: Theme.of(context).textTheme.headline3),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Table(
                      columnWidths: {0: FractionColumnWidth(0.25)},
                      border: TableBorder(
                          horizontalInside:
                              BorderSide(width: 1.0, color: Colors.grey[400])),
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
                              child: Obx(() => Text(
                                  '${deviceController.device.lastUser}',
                                  style:
                                      Theme.of(context).textTheme.bodyText2)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => Text(
                                          '${deviceController.device?.lastUserPhoneNumber}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        launch(
                                            'tel:${deviceController.device?.lastUserPhoneNumber}');
                                      },
                                      icon: Icon(
                                        Icons.phone,
                                        // size: mediumTextSize,
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
                                      '${deviceController.device.lastUseTime != null ? DateFormat('E, d/MM/yyyy').format(deviceController.device.lastUseTime) : ''}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                                      '${deviceController.device.lastUseTime != null ? DateFormat('HH:mm').format(deviceController.device.lastUseTime) : ''}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                    'Problems',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text('\n\n\n\n\n\n\n\n\n\n\n\n\n')),
                  SizedBox(
                    height: 100.0,
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: _qrScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _qrScanButton() => qrScanButton();

  Widget _reportButton() => Container(
        margin: EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed('/reportproblem', arguments: deviceId);
            },
            child: Text('Report'),
            style: ElevatedButton.styleFrom(
                primary: Colors.amber, onPrimary: Colors.black),
          ),
        ),
      );
}

// Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Status'),
//                             Container(
//                               padding: EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(color: Colors.grey),
//                               child: Text('Available'),
//                             )
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Status'),
//                             Container(
//                               padding: EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(color: Colors.grey),
//                               child: Text('Available'),
//                             )
//                           ],
//                         )
//                       ],
//                     )
