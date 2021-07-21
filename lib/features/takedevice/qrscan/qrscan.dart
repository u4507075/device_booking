import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './qrscan_controller.dart';
export './qrscan_controller.dart';

Widget qrScanButton() {
  return FloatingActionButton(
      backgroundColor: Get.theme.accentColor,
      child: Icon(
        Icons.qr_code_scanner_outlined,
        color: Get.theme.accentIconTheme.color,
      ),
      onPressed: () async => _checkQrScanPermission());
}

Widget qrScanButtonExtended() {
  return FloatingActionButton.extended(
      backgroundColor: Get.theme.accentColor,
      label: Text(
        'Scan ',
        style: Get.theme.accentTextTheme.headline6,
      ),
      icon: Icon(
        Icons.qr_code_scanner_outlined,
        color: Get.theme.accentIconTheme.color,
      ),
      onPressed: () async => _checkQrScanPermission());
}

void _qrCodeScanner() async {
  QrCodeController controller = Get.put(QrCodeController());
  DeviceController deviceController = Get.put(DeviceController());

  Device? _device = deviceController.device;

  await controller.scanQrCode();
  // print('${controller.qrCode}');

  //?cancel scan qr -> not navigate
  if (controller.qrCode.value == '-1') {
    //?return previous device info
    deviceController.setDevice(_device);
    Get.snackbar('QR Scan cancelled', 'QR scanner was cancelled by user',
        backgroundColor: Get.theme.canvasColor.withOpacity(0.6));
  } else {
    await deviceController.fetchDevice(controller.qrCode.value);
    if (deviceController.device != null) {
      Get.toNamed('/takedevice');
    } else {
      //return previous deviceinfo
      deviceController.setDevice(_device);
      Get.snackbar('QR scan error', 'QR code not found',
          backgroundColor: Get.theme.canvasColor.withOpacity(0.6));
    }
  }
}

void _checkQrScanPermission() async {
  UserController userController = Get.put(UserController());
  if (!Get.find<AuthController>().firebaseUser!.isAnonymous) {
    if (userController.streamUser?.isCompleted ?? false) {
      _qrCodeScanner();
    } else {
      Get.snackbar('User Profile Incompleted',
          'Please complete your profile before continue',
          backgroundColor: Get.theme.canvasColor.withOpacity(0.6));
    }
  } else {
    Get.snackbar(
        'Access is forbidden', 'Anonymous user cannot use this function',
        backgroundColor: Get.theme.canvasColor.withOpacity(0.6));
  }
}
