import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/models/pages/pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/pages/bookdevice/inuse.dart';
import 'package:get/get.dart';

class Confirmation extends StatelessWidget {
  final String deviceId = Get.parameters['deviceId'].toString();
  final String location = Get.parameters['location'].toString();

  @override
  Widget build(BuildContext context) {
    DeviceController deviceController = Get.put(DeviceController());
    UserController userController = Get.put(UserController());
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(color: Colors.grey),
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Align(
                    child: Obx(() => Text(
                        '${deviceController.device.deviceType.capitalize} ${deviceController.device.name.capitalize}'))),
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ), //TODO add image of the device
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirmation',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  _deviceInfo(userController: userController),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Take Device to',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                    // margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text('$location'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    alignment: Alignment.centerRight,
                    child: Text('Do you want to confirm?',
                        style: Theme.of(context).textTheme.headline3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(),
                      ),
                      Flexible(
                          flex: 2,
                          child: OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Edit'))),
                      Flexible(
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () async {
                                // print('$deviceId $location ');
                                await Device().takeDevice(
                                    deviceId: deviceId,
                                    userId: userController.streamUser.uid,
                                    location: location);
                                Get.offNamedUntil('/inuse', (route) => false);
                              },
                              child: Text('Confirm'))),
                    ],
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}

class _deviceInfo extends StatelessWidget {
  _deviceInfo({
    Key key,
    @required this.userController,
  }) : super(key: key);

  final UserController userController;
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
      child: Table(
        columnWidths: {0: FractionColumnWidth(0.25)},
        border: TableBorder(
            horizontalInside: BorderSide(width: 1.0, color: Colors.grey[400])),
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Text('User', style: Theme.of(context).textTheme.bodyText2),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(() => Text(
                    '${userController.streamUser.role.capitalize} ${userController.streamUser.firstname.capitalize} ${userController.streamUser.lastname.capitalize}',
                    style: Theme.of(context).textTheme.bodyText2)),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Text('Tel.', style: Theme.of(context).textTheme.bodyText2),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(
                    () => Text('${userController.streamUser.phoneNumber}',
                        style: Theme.of(context).textTheme.bodyText2),
                  )),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Text('Date', style: Theme.of(context).textTheme.bodyText2),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('${DateFormat('E, d/MM/yyyy').format(now)}',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Text('Time', style: Theme.of(context).textTheme.bodyText2),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('${DateFormat('HH:mm').format(now)}',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
