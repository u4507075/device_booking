// import 'package:device_booking/services/database.dart';
// import 'package:device_booking/models/device/device2.dart';
// import 'package:device_booking/models/device/devicestatus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:clipboard/clipboard.dart';
// import 'dart:async';
// import 'package:device_booking/models/pages/pages.dart';
// import 'package:device_booking/models/user/Userdetail.dart';
// import 'package:device_booking/pages/bookdevice/busy_device.dart';
// import 'package:device_booking/pages/bookdevice/Select_location.dart';
// import 'package:device_booking/pages/loading.dart';

// class QrScan extends StatelessWidget {
//   const QrScan({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: child,
//     );
//   }
// }

// //หน้า qr มี ค่าอ่านได้ กับปุ่มสแกน
// class QRScan extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _QRScanState();
// }

// //กำหนดค่าแรกเริ่มให้แสดงเป็น Unknown
// class _QRScanState extends State<QRScan> {

//   @override
//   void initState() {
//     super.initState();

//     // scanQRCode();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(),
//       );

//  Future<void> scanQR() async {
//     String qrScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       qrScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//       print(qrScanRes);
//     } on PlatformException {
//       qrScanRes = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//       _qrCode = qrScanRes;
//   }

//   Future<void> scanQRCode() async {
//     try {
//       final qrCode = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.QR,
//       );
//       if (qrCode == '-1') {
//         Navigator.pushNamed(context, '/home');
//       } else {
//         Navigator.pushNamed(context, "/loading");
//         if (!mounted) return;
//         DBService().fetchDevice2(qrCode).then((value) => setState(() {
//               this.qrCode = qrCode;
//               this.device = value;
//             }));
//         DBService().fetchDeviceStatus(qrCode).then((status) {
//           setState(() {
//             this.qrCode = qrCode;
//             this.devicestatus = status;
//             this.UID = status.userid;
//             this.BorrowTime = status.timestamp;
//             this.borrowPlace = status.borrowPlace;
//             print(UID);
//           });
//           DBService().fetchUserDetails(UID).then((userr) {
//             setState(() {
//               this.userdetails = userr;
//               email = userr.email;
//               firstname = userr.firstname;
//               imagePath = userr.imagePath;
//               lastname = userr.lastname;
//               role = userr.role;
//               telephone = userr.telephone;
//               print(UID);
//             });
//             DBService().fetchUserDetails(myID).then((me) => setState(() {
//                   this.userdetails = me;
//                   Memail = me.email;
//                   Mfirstname = me.firstname;
//                   MimagePath = me.imagePath;
//                   Mlastname = me.lastname;
//                   Mrole = me.role;
//                   Mtelephone = me.telephone;
//                   Navigator.pop(context);
//                   if (status.status == "borrowed") {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => MyTest(
//                                 myID: myID,
//                                 qrCode: qrCode,
//                                 Memail: Memail,
//                                 Mfirstname: Mfirstname,
//                                 MimagePath: MimagePath,
//                                 Mlastname: Mlastname,
//                                 Mrole: Mrole,
//                                 Mtelephone: Mtelephone,
//                                 BorrowPlace: borrowPlace,
//                                 BorrowTime: BorrowTime,
//                                 email: email,
//                                 firstname: firstname,
//                                 imagePath: imagePath,
//                                 lastname: lastname,
//                                 role: role,
//                                 telephone: telephone)));
//                   } else {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => LocationList(
//                                 myID: myID,
//                                 qrCode: qrCode,
//                                 Memail: Memail,
//                                 Mfirstname: Mfirstname,
//                                 MimagePath: MimagePath,
//                                 Mlastname: Mlastname,
//                                 Mrole: Mrole,
//                                 Mtelephone: Mtelephone)));
//                   }
//                 }));
//           });
//         });
//       }
//     } on PlatformException {
//       qrCode = 'Failed to get platform version.';
//     }
//   }
// }
