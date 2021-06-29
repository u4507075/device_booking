import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';

class InUse extends StatefulWidget {
  @override
  _InUseState createState() => _InUseState();
}

class _InUseState extends State<InUse> {
  final UserController userController = Get.put(UserController());
  final TimerController timerController = Get.put(TimerController());
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Text(
            'Using Device',
            style: appBarTextStyle,
          ),
        ),
        body: GetX<UserController>(
          builder: (controller) {
            // DateTime now = DateTime.now();
            return FutureBuilder(
                future: controller.lastUserLog(),
                builder: (context, snapshot) {
                  UserLog? log = snapshot.data as UserLog? ?? UserLog();
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
                                  confirmReturnDevice();
                                  // DBService().returnDevice(
                                  //     userController.log.deviceId,
                                  //     userController.streamUser.uid);
                                  // Get.offAllNamed('/');
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      margin: EdgeInsets.all(5.0),
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      child: Obx(() {
                                        timerController
                                            .timeDifference(takeTime!);
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
        ),
      ),
    );
  }
}
