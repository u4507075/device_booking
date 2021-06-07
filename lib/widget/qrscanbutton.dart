import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/controller/qrcode_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget qrScanButton() {
  QrCodeController controller = Get.put(QrCodeController());
  DeviceController deviceController = Get.put(DeviceController());

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
        // print('${controller.qrCode}');
        await deviceController.fetchDevice(controller.qrCode.value);
        //cancel scan qr -> not navigate
        if (controller.qrCode.value == '-1') {
          Get.snackbar('QR Scan cancelled', 'QE scanner was cancelled by user');
        } else if (deviceController.device != null) {
          Get.toNamed('/takedevice');
        } else {
          Get.snackbar('QR scan error', 'QR code not found');
        }
        // await deviceController.fetchDevice('ZKUFINrPPKGWfZiiFk5E');
        // if (deviceController.device != null) {
        //   Get.toNamed('/selectlocation');
        // } else {
        //   Get.snackbar('QR scan error', 'QR code not found');
        // }
        // Get.toNamed('/selectlocation');
      }

      //send deviceId to TakeDevice()

      );
}

//TODO check phone number and role first
