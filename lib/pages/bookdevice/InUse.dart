import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/controller/timer_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/services/database.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_booking/models/pages/pages.dart';
import 'package:device_booking/pages/deviceinfo/reportproblem.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InUse extends StatefulWidget {
  // DeviceController controller = Get.put(DeviceController(deviceId));

  @override
  _InUseState createState() => _InUseState();
}

class _InUseState extends State<InUse> {
  final UserController userController = Get.put(UserController());
  final TimerController timerController = Get.put(TimerController());

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
        body: GetX<UserController>(
          builder: (controller) {
            DateTime now = DateTime.now();
            return FutureBuilder(
                future: controller.lastUserLog(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    DateTime takeTime = snapshot.data.time;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            child: Obx(() {
                              timerController.timeDifference(takeTime);
                              return Text(
                                  '${timerController.duration.toString().split('.').first.padLeft(8, "0")}');
                            }),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                DBService().returnDevice(
                                    userController.log.deviceId,
                                    userController.streamUser.uid);
                                Get.offAllNamed('/');
                              },
                              child: Text('Return Device')),
                        ],
                      ),
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

// class MainPageBusy extends StatefulWidget {
//   final FirebaseApp app;
//   String qrCode;
//   MainPageBusy({Key key, this.app, this.qrCode}) : super(key: key);

//   @override
//   _MainPageBusyState createState() {
//     return _MainPageBusyState(qrCode: qrCode);
//   }
// }

// class _MainPageBusyState extends State<MainPageBusy> {
//   String time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//   InUsePage INUSE = InUsePage();
//   StreamController<String> _controller = StreamController.broadcast();
//   StreamController<String> _controllerTime = StreamController();
//   String qrCode;
//   String DeviceID;
//   _MainPageBusyState({this.qrCode});
//   final databaseReference = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     super.initState();
//     INUSE.fetchAll(_controller);
//     test(qrCode);
//     DeviceID = qrCode;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: StreamBuilder<Object>(
//             stream: _controller.stream,
//             builder: (context, snapshot) {
//               if (snapshot != null &&
//                   snapshot.hasData &&
//                   snapshot.data == "success") {
//                 return Text(INUSE.appBar, style: TextStyle(fontSize: 28));
//               } else {
//                 return Text('Using Device');
//               }
//             }),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 StreamBuilder<Object>(
//                     stream: _controller.stream,
//                     builder: (context, snapshot) {
//                       if (snapshot != null &&
//                           snapshot.hasData &&
//                           snapshot.data == "success") {
//                         return ElevatedButton(
//                             child: Text(INUSE.upperLeftButton),
//                             onPressed: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                         ReportProblem(deviceId: DeviceID))));
//                       } else {
//                         return ElevatedButton(
//                             child: Text("Report"),
//                             onPressed: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                         ReportProblem(deviceId: DeviceID))));
//                       }
//                     }),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.width / 2,
//                     width: MediaQuery.of(context).size.width / 2,
//                     child: StreamBuilder<Object>(
//                         stream: _controller.stream,
//                         builder: (context, snapshot) {
//                           if (snapshot != null &&
//                               snapshot.hasData &&
//                               snapshot.data == "success") {
//                             return Image.network(INUSE.picture);
//                           } else {
//                             return Image.network(
//                                 'https://device-tracking-system.obs.ap-southeast-2.myhuaweicloud.com/img/device.png');
//                           }
//                         }),
//                   ),
//                   Container(
//                     //padding: const EdgeInsets.all(10),
//                     child: StreamBuilder<Object>(
//                         stream: _controller.stream,
//                         builder: (context, snapshot) {
//                           if (snapshot != null &&
//                               snapshot.hasData &&
//                               snapshot.data == "success") {
//                             return Text(INUSE.duration);
//                           } else {
//                             return Text('Duration');
//                           }
//                         }),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(15),
//                     child: StreamBuilder<String>(
//                         stream: _controllerTime.stream,
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             return Text(
//                               snapshot.data,
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             );
//                           } else {
//                             return Text(
//                               '-- hours -- minutes -- secs',
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             );
//                           }
//                         }), //duration time
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     child: StreamBuilder<Object>(
//                         stream: _controller.stream,
//                         builder: (context, snapshot) {
//                           if (snapshot != null &&
//                               snapshot.hasData &&
//                               snapshot.data == "success") {
//                             return ElevatedButton(
//                                 child: Text(INUSE.re),
//                                 onPressed: () {
//                                   updateLastest();
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (BuildContext context) => Home(),
//                                   ));
//                                 });
//                           } else {
//                             return ElevatedButton(
//                                 child: Text("คืนอุปกรณ์"),
//                                 onPressed: () {
//                                   updateLastest();
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (BuildContext context) => Home(),
//                                   ));
//                                 });
//                           }
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ));

//   void updateLastest() {
//     try {
//       databaseReference
//           .collection('device_status')
//           .doc(qrCode)
//           .update({'status': 'available', 'timestamp': time});
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void test(qrCode) async {
//     CollectionReference collection =
//         FirebaseFirestore.instance.collection('device_status');
//     DocumentSnapshot documentSnapshot = await collection.doc(qrCode).get();
//     if (documentSnapshot.exists) {
//       Map<String, dynamic> data = documentSnapshot.data();
//       String datetime = data["timestamp"];
//       var time = const Duration(milliseconds: 900);
//       Timer.periodic(time, (timer) {
//         var dateTime1 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(datetime);
//         final hrs = DateTime.now().difference(dateTime1).inHours;
//         final mins = DateTime.now().difference(dateTime1).inMinutes;
//         final secs = DateTime.now().difference(dateTime1).inSeconds;
//         int min = mins % 60;
//         int sec = secs % 60;
//         if (hrs == 0) {
//           _controllerTime.add('$min minutes $sec secs');
//           if (min == 0) {
//             _controllerTime.add('$sec secs');
//           } else {
//             _controllerTime.add('$min minutes $sec secs');
//           }
//         } else {
//           _controllerTime.add('$hrs hours $min minutes $sec secs');
//           if (min == 0) {
//             _controllerTime.add('$hrs hours $sec secs');
//           } else {
//             _controllerTime.add('$hrs hours $min minutes $sec secs');
//           }
//         }
//       });
//     }
//   }
// }
