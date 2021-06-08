import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/controller/qrcode_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget qrScanButton() {
  QrCodeController controller = Get.put(QrCodeController());
  DeviceController deviceController = Get.put(DeviceController());
  UserController userController = Get.put(UserController());

  void qrCodeScanner() async {
    Device _device = deviceController.device;

    await controller.scanQrCode();
    // print('${controller.qrCode}');
    await deviceController.fetchDevice(controller.qrCode.value);
    //cancel scan qr -> not navigate
    if (controller.qrCode.value == '-1') {
      //return previous deviceinfo
      deviceController.setDevice(_device);
      Get.snackbar('QR Scan cancelled', 'QR scanner was cancelled by user');
    } else if (deviceController.device != null) {
      Get.toNamed('/takedevice');
    } else {
      //return previous deviceinfo
      deviceController.setDevice(_device);
      Get.snackbar('QR scan error', 'QR code not found');
    }
  }

  return FloatingActionButton.extended(
      backgroundColor: Colors.grey[100],
      label: Text('ยืมอุปกรณ์',
          style: TextStyle(
            fontSize: mediumTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      icon: Icon(
        Icons.qr_code_scanner_outlined,
        color: Colors.black,
      ),
      onPressed: () async {
        if (userController.user.phoneNumber != '') {
          qrCodeScanner();
        } else {
          Get.snackbar('User Profile Incompleted',
              'Please complete your profile before continue');
        }
      });
}

//TODO check phone number and role first
