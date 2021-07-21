import 'dart:async';

import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/utils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:async/async.dart';

class InUse extends StatefulWidget {
  @override
  _InUseState createState() => _InUseState();
}

class _InUseState extends State<InUse> {
  final UserController userController = Get.find<UserController>();
  // final TimerController timerController = Get.put(TimerController());
  final DeviceController deviceController = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: Text(
          //   'Using Device',
          //   style: Get.theme.accentTextTheme.headline6,
          // ),
        ),
        body: FutureBuilder<Device?>(
          future: userController.lastUseDevice(),
          initialData: Device(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Device? device = snapshot.data as Device;

            deviceController.setDevice(device);
            return <Widget>[
              GlowDeviceImage().alignment(Alignment.topCenter),
              <Widget>[
                Text(
                  '${device.deviceType?.capitalize} ${device.name}',
                  style: Get.textTheme.headline6,
                ).padding(top: 20),
                Text(
                  'In Use',
                  style: Get.textTheme.bodyText1!
                      .copyWith(color: Get.theme.errorColor),
                ).padding(vertical: 10),
                Divider(),
                timerText(device.lastUseTime ?? DateTime.now()),
                Divider(),
                ReturnButton()
              ]
                  .toColumn(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end)
                  .decorated(
                    color: Get.theme.canvasColor,
                  )
                  // .card(
                  //     color: Get.theme.cardColor.withOpacity(1), elevation: 10)
                  .clipRRect(topLeft: 20, topRight: 20)
                  .elevation(20, borderRadius: BorderRadius.circular(20))
                  .padding(top: 20, horizontal: 20)
                  // .constrained(height: 250)
                  // .padding(bottom: 100)
                  .alignment(Alignment.bottomCenter),
              // Align(alignment: Alignment.bottomCenter, child: ReturnButton()),
            ].toStack();
          },
        ),
      ),
    );
  }
}

Widget timerText(DateTime timeStart) {
  TextStyle _style = Get.textTheme.headline2!;
  return StreamBuilder(
    stream: Stream.periodic(Duration(seconds: 1)),
    builder: (_, __) {
      String time = _durationFormat(DateTime.now().difference(timeStart));
      List<String> list = time.split('');
      return <Widget>[
        for (int i = 0; i < list.length; i++)
          Text(
            list[i],
            style: _style,
            textAlign: TextAlign.center,
          ).constrained(width: _style.fontSize! / 1.6)
      ]
          .toRow(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min)
          .paddingSymmetric(vertical: 10);
    },
  );
}

String _durationFormat(Duration duration) {
  return duration.toString().split('.').first.padLeft(8, "0");
}

class GlowDeviceImage extends StatelessWidget {
  const GlowDeviceImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      endRadius: 170.0,
      glowColor: Colors.red[200]!,
      duration: Duration(milliseconds: 3000),
      repeat: true,
      repeatPauseDuration: Duration(milliseconds: 2000),
      child: DeviceImage(),
    );
  }
}

class DeviceImage extends GetView<DeviceController> {
  const DeviceImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _widget = ((controller.device!.photoURL != null &&
                controller.device!.photoURL != '')
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: controller.device?.photoURL ?? '',
                fadeInDuration: Duration(milliseconds: 300),
              )
            : Image.asset('assets/images/device_placeholder.png'))
        .fittedBox(fit: BoxFit.fitWidth)
        .constrained(width: Get.height / 4, height: Get.height / 4)
        .clipOval()
        .elevation(5,
            borderRadius: BorderRadius.circular(100),
            shadowColor: Colors.red[100]!.withOpacity(0.5))
        .padding(all: 20);
    return _widget;
  }
}

class ReturnButton extends StatelessWidget {
  // const ReturnButton({Key? key}) : super(key: key);
  final DeviceController deviceController = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    void confirmReturnDevice() {
      Get.defaultDialog(
        title: 'Returning  Device',
        textConfirm: 'Return device',
        confirmTextColor: Colors.white,
        cancelTextColor: Colors.black,
        buttonColor: Colors.red[800],
        middleText: 'Confirm to return device?',
        textCancel: 'Cancel',
        onConfirm: () async {
          deviceController.returnDevice(device: deviceController.device!).then(
              (_) => Get.snackbar('MedTrack', 'Return Device Successful',
                  backgroundColor: Get.theme.canvasColor.withOpacity(0.6)));
          Get.back();
          // print(deviceController.device!.deviceId!);
        },
        onCancel: () {
          print('Cancel');
        },
      );
    }

    return Styled.text('Return', style: Get.theme.accentTextTheme.headline6)
        .padding(all: 20)
        .center()
        .ripple()
        .decorated(
          color: Colors.red[800],
          borderRadius: BorderRadius.circular(20),
        )
        .elevation(10, shadowColor: Colors.red[800]!)
        .clipRRect(all: 20)
        .constrained(width: Get.width, height: 80)
        .gestures(onTap: () {
      confirmReturnDevice();
    }).padding(all: 20);

    // return AvatarGlow(
    //   endRadius: 120.0,
    //   glowColor: Colors.red[200]!,
    //   duration: Duration(milliseconds: 100),
    //   repeat: true,
    //   repeatPauseDuration: Duration(milliseconds: 100),
    //   child: Material(
    //     // elevation: 20.0,
    //     shadowColor: Colors.red[900],

    //     child: ElevatedButton(
    //       onPressed: () {
    //         confirmReturnDevice();
    //       },
    //       style: ElevatedButton.styleFrom(
    //           shape: CircleBorder(), primary: Colors.red[900]),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text(
    //             'Return Device',
    //             style: Get.textTheme.bodyText1!
    //                 .copyWith(color: Get.theme.canvasColor),
    //           ).padding(all: 10)
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.deviceController,
    required this.timerController,
  }) : super(key: key);

  final DeviceController deviceController;
  final TimerController timerController;

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (controller) {
        // DateTime now = DateTime.now();
        return FutureBuilder<UserLog?>(
            future: controller.lastUserLog(),
            initialData: UserLog(),
            builder: (context, snapshot) {
              UserLog? log = snapshot.data ?? UserLog();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                DateTime? takeTime = log.time;
                deviceController.setId(log.deviceId);
                deviceController.fetchDevice(log.deviceId);
                return Stack(
                  children: [
                    Center(
                      child: AvatarGlow(
                        endRadius: 150.0,
                        glowColor: Colors.red[200]!,
                        duration: Duration(milliseconds: 2500),
                        repeat: true,
                        repeatPauseDuration: Duration(milliseconds: 500),
                        child: Material(
                          elevation: 10.0,
                          shape: CircleBorder(),
                          child: ElevatedButton(
                            onPressed: () {
                              // confirmReturnDevice();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: Colors.red[900]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Tap to',
                                  style: Get.textTheme.button,
                                ),
                                Text(
                                  'Return Device',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(flex: 2),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You're now using",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5.0)),
                                  margin: EdgeInsets.all(5.0),
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: Obx(() => Text(
                                        '${deviceController.device?.deviceType?.capitalize} ${deviceController.device?.name?.capitalize}',
                                        // '${deviceController.deviceInfo?.deviceType?.capitalize} ${deviceController.deviceInfo?.name?.capitalize}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 5,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Duration',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5.0)),
                                  margin: EdgeInsets.all(5.0),
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: Obx(() {
                                    timerController.timeDifference(takeTime!);
                                    return Text(
                                        '${timerController.duration.toString().split('.').first.padLeft(8, "0")}');
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          )
                        ],
                      ),
                    )
                  ],
                );

                //https://flutterigniter.com/how-to-format-duration/
              }
            });
      },
    );
  }
}
