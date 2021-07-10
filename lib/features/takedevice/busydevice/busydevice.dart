import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_booking/core/core.dart';
import 'package:intl/intl.dart';

class BusyDevice extends StatelessWidget {
  var deviceController = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text('Busy Device'),
          centerTitle: true,
        ),
        body: ListView(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(color: Colors.grey),
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Align(
                    child: Obx(() => Text(
                        '${deviceController.device?.deviceType?.capitalize} ${deviceController.device?.name?.capitalize}'))),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: BackButton(
                //     onPressed: () {
                //       Get.back();
                //     },
                //   ),
                // ),
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
                  _deviceInfo(),
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
                    child: Text('${deviceController.device?.location}'),
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
                              child: Text('Cancel'))),
                      Flexible(
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () async {
                                Get.offNamed('/selectlocation');
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
  final deviceController = Get.put(DeviceController());
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
            horizontalInside: BorderSide(width: 1.0, color: Colors.grey[400]!)),
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
                child: Obx(() => Text('${deviceController.device?.lastUser}',
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
                    () => Text(
                        '${deviceController.device?.lastUserPhoneNumber}',
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
                child: Obx(
                  () => Text(
                      '${DateFormat('E, d/MM/yyyy').format(deviceController.device!.lastUseTime!)}',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
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
                child: Obx(
                  () => Text(
                      '${DateFormat('HH:mm').format(deviceController.device!.lastUseTime!)}',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
