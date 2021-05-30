import 'package:device_booking/controller/qrcode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget qrScanButton() {
  QrCodeController controller = Get.put(QrCodeController());

  return FloatingActionButton.extended(
    backgroundColor: Colors.grey[100],
    label: Text('ยืมอุปกรณ์',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
    icon: Icon(
      Icons.qr_code_scanner_outlined,
      color: Colors.black,
    ),
    onPressed: () async {
      await controller.scanQrCode();
      print('${controller.qrCode}');

      //cancel scan qr -> not navigate
      if (controller.qrCode != '-1') {
        Get.toNamed('/takedevice', arguments: controller.qrCode);
      }

      //send deviceId to TakeDevice()
    },
  );
}
