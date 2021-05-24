import 'package:device_booking/services/database.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/devicestatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:async';
import 'package:device_booking/models/pages.dart';
import 'package:device_booking/models/Userdetail.dart';
import 'package:device_booking/pages/bookdevice/busy_device.dart';
import 'package:device_booking/pages/bookdevice/Select_location.dart';
import 'package:device_booking/pages/loading.dart';

//หน้า qr มี ค่าอ่านได้ กับปุ่มสแกน
class QRScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanState();
}

//กำหนดค่าแรกเริ่มให้แสดงเป็น Unknown
class _QRScanState extends State<QRScan> {
  String qrCode = 'Unknown';
  String UID;
  String email;
  String firstname;
  String imagePath;
  String lastname;
  String role;
  String telephone;
  String BorrowTime;
  String BorrowPlace;
  String Memail;
  String Mfirstname;
  String MimagePath;
  String Mlastname;
  String Mrole;
  String Mtelephone;
  String myID = 'myID';

  Device device = Device().defaultValue();
  DeviceStatus devicestatus = DeviceStatus().defaultValue();
  UserDetails userdetails = UserDetails().defaultValue();

  @override
  void initState() {
    super.initState();

    scanQRCode();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold();

  Future<void> scanQRCode() async {
    try {

      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      Navigator.pushNamed(context,"/loading");
      if (!mounted) return;
      FirebaseDB().fetchDevice(qrCode).then((value) => setState(() {
        this.qrCode = qrCode;
        this.device = value;
      }));
      FirebaseDB().fetchDeviceStatus(qrCode).then((status) {  setState(() {
        this.qrCode = qrCode;
        this.devicestatus = status;
        this.UID = status.userid;
        this.BorrowTime = status.timestamp;
        this.BorrowPlace = status.BorrowPlace;
        print(UID);
      });
      FirebaseDB().fetchUserDetails(UID).then((userr) { setState(() {
        this.userdetails = userr;
        email = userr.email;
        firstname = userr.firstname;
        imagePath = userr.imagePath;
        lastname = userr.lastname;
        role = userr.role;
        telephone = userr.telephone;
        print(UID);
      });
      FirebaseDB().fetchUserDetails(myID).then((me) => setState(() {
        this.userdetails = me;
        Memail = me.email;
        Mfirstname = me.firstname;
        MimagePath = me.imagePath;
        Mlastname = me.lastname;
        Mrole = me.role;
        Mtelephone = me.telephone;
        Navigator.pop(context);
        if (status.status == "borrowed") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>MyTest(myID:myID , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone , BorrowPlace:BorrowPlace , BorrowTime:BorrowTime , email:email , firstname:firstname , imagePath:imagePath , lastname:lastname , role:role , telephone:telephone)));
        }else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>LocationList(myID:myID , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)));
        }
      }));});});
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
