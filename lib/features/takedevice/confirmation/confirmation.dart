import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class Confirmation extends StatelessWidget {
  final String deviceId = Get.parameters['deviceId'].toString();
  final String location = Get.parameters['location'].toString();

  @override
  Widget build(BuildContext context) {
    DeviceController deviceController = Get.put(DeviceController());
    UserController userController = Get.find<UserController>();
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Styled.icon(Icons.arrow_back, size: 26)
                .padding(all: 5)
                .decorated(color: Colors.black.withOpacity(0.4))
                .clipOval()
                .gestures(
                  onTap: () => Get.back(),
                )
                .padding(all: 5),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: Get.height),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ((deviceController.device!.photoURL != null &&
                                    deviceController.device!.photoURL != '')
                                ? FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/images/device_placeholder.png'),
                                    image: NetworkImage(
                                        deviceController.device?.photoURL ??
                                            ''),
                                    fadeOutDuration:
                                        Duration(milliseconds: 300),
                                    fadeOutCurve: Curves.easeOutBack,
                                    fadeInDuration: Duration(milliseconds: 300),
                                  )
                                : Image.asset(
                                    'assets/images/device_placeholder.png'))
                            .fittedBox(fit: BoxFit.cover)
                            .constrained(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width - 100,
                            )
                            // .backgroundColor(Colors.white)
                            .clipRRect(
                              bottomLeft: 50,
                            ),
                      ],
                    ),
                    Text(deviceController.device!.deviceType!.capitalize! +
                            ' ' +
                            deviceController.device!.name!)
                        .textStyle(Theme.of(context).textTheme.headline6!)
                        .alignment(Alignment.center)
                        .padding(all: 20),
                    _DeviceInfo(
                      location: location,
                    ).paddingSymmetric(horizontal: 20),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
            _confirmButton(location: location).alignment(Alignment.bottomCenter)
          ].toStack()),
    );
  }
}

Widget _confirmButton({required String location}) {
  DeviceController deviceController = Get.put(DeviceController());
  UserController userController = Get.find<UserController>();
  return Styled.text('Confirm',
          style:
              Get.textTheme.headline6!.copyWith(color: Get.theme.canvasColor))
      .padding(all: 20)
      .center()
      .ripple()
      .decorated(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(20),
      )
      .elevation(10, shadowColor: Colors.red[800]!)
      .clipRRect(all: 20)
      .constrained(height: 80)
      .gestures(onTap: () async {
    await DeviceController().takeDevice(
        device: deviceController.device!,
        user: userController.streamUser!,
        location: location);
    Get.offAllNamed('/');
  }).padding(all: 20);
}

class _DeviceInfo extends StatelessWidget {
  _DeviceInfo({required this.location});

  String location;

  final UserController userController = Get.put(UserController());
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
                child: Obx(() => Text(
                    '${userController.streamUser?.role.capitalize} ${userController.streamUser?.firstname.capitalize} ${userController.streamUser?.lastname.capitalize}',
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
                        '${formatPhoneNumber(userController.streamUser!.phoneNumber)}',
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
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Target',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('$location',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
