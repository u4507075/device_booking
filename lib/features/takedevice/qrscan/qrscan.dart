import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './qrscan_controller.dart';
export './qrscan_controller.dart';

Widget qrScanButton() {
  QrCodeController controller = Get.put(QrCodeController());
  DeviceController deviceController = Get.put(DeviceController());
  UserController userController = Get.put(UserController());

  void qrCodeScanner() async {
    Device? _device = deviceController.device;

    await controller.scanQrCode();
    // print('${controller.qrCode}');
    await deviceController.fetchDevice(controller.qrCode.value);
    //cancel scan qr -> not navigate
    if (controller.qrCode.value == '-1') {
      //return previous deviceinfo
      deviceController.setDevice(_device);
      Get.snackbar('QR Scan cancelled', 'QR scanner was cancelled by user');
    } else {
      await deviceController.fetchDevice(controller.qrCode.value);
      if (deviceController.device != null) {
        Get.toNamed('/takedevice');
      } else {
        //return previous deviceinfo
        deviceController.setDevice(_device);
        Get.snackbar('QR scan error', 'QR code not found');
      }
    }
  }

  return FloatingActionButton(
      backgroundColor: Colors.grey[100],
      // label: Text('ยืมอุปกรณ์',
      //     style: TextStyle(
      //       fontSize: mediumTextSize,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.black,
      //     )),
      child: Icon(
        Icons.qr_code_scanner_outlined,
        color: Colors.black,
      ),
      onPressed: () async {
        print('${userController.streamUser}');
        if (!Get.find<AuthController>().firebaseUser!.isAnonymous) {
          if (userController.streamUser?.isCompleted ?? false) {
            qrCodeScanner();
          } else {
            Get.snackbar('User Profile Incompleted',
                'Please complete your profile before continue');
          }
        } else {
          Get.snackbar(
              'Access is forbidden', 'Anonymous user cannot use this function');
        }
      });
}

Widget qrScanButtonExtended() {
  QrCodeController controller = Get.put(QrCodeController());
  DeviceController deviceController = Get.put(DeviceController());
  UserController userController = Get.put(UserController());

  void qrCodeScanner() async {
    Device? _device = deviceController.device;

    await controller.scanQrCode();
    // print('${controller.qrCode}');

    //cancel scan qr -> not navigate
    if (controller.qrCode.value == '-1') {
      //return previous deviceinfo
      deviceController.setDevice(_device);
      Get.snackbar('QR Scan cancelled', 'QR scanner was cancelled by user');
    } else {
      await deviceController.fetchDevice(controller.qrCode.value);
      if (deviceController.device != null) {
        Get.toNamed('/takedevice');
      } else {
        //return previous deviceinfo
        deviceController.setDevice(_device);
        Get.snackbar('QR scan error', 'QR code not found');
      }
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
        print('${userController.streamUser?.firstname}');

        if (!Get.find<AuthController>().firebaseUser!.isAnonymous) {
          if (userController.streamUser?.isCompleted ?? false) {
            qrCodeScanner();
          } else {
            Get.snackbar('User Profile Incompleted',
                'Please complete your profile before continue');
          }
        } else {
          Get.snackbar(
              'Access is forbidden', 'Anonymous user cannot use this function');
        }
      });
}