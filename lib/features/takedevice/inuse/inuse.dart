import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:styled_widget/styled_widget.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Text(
            'Using Device',
            style: appBarTextStyle,
          ),
        ),
        body: FutureBuilder<UserLog?>(
          future: userController.lastUserLog(),
          initialData: UserLog(),
          builder: (BuildContext context, AsyncSnapshot snapshotLog) {
            var deviceId = (snapshotLog.data as UserLog).deviceId;
            return FutureBuilder(
              future: deviceController.fetchDevice(deviceId),
              initialData: Device(),
              builder: (BuildContext context, AsyncSnapshot snapshotDevice) {
                print(snapshotDevice.data);
                return [
                  ReturnButton(),
                  Text(''),
                ].toColumn().center();
              },
            );
          },
        ),
      ),
    );
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
          deviceController.returnDevice(device: deviceController.device!);
          Get.back();
          // print(deviceController.device!.deviceId!);
        },
        onCancel: () {
          print('Cancel');
        },
      );
    }

    return AvatarGlow(
      endRadius: 150.0,
      glowColor: Colors.red[200]!,
      duration: Duration(milliseconds: 2500),
      repeat: true,
      repeatPauseDuration: Duration(milliseconds: 500),
      child: Material(
        // elevation: 20.0,
        shadowColor: Colors.grey[200],
        shape: CircleBorder(),
        child: ElevatedButton(
          onPressed: () {
            confirmReturnDevice();
          },
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(), primary: Colors.red[900]),
          child: SizedBox(
            height: Get.height / 4,
            width: Get.height / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tap to',
                  style: Get.textTheme.bodyText1!
                      .copyWith(color: Get.theme.canvasColor),
                ),
                Text(
                  'Return Device',
                  style: Get.textTheme.bodyText1!
                      .copyWith(color: Get.theme.canvasColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                                  style: Theme.of(context).textTheme.headline2,
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
