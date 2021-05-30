import 'package:device_booking/models/qrcode.dart';
import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class QrCodeController extends GetxController {
  Rxn<String> qrCode = Rxn<String>();

  // QrCode get code => qrCode.value;

  @override
  onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  // set code(QrCode value) => this.qrCode.value = value;

  void clear() {
    qrCode.value = '';
  }

  Future<void> scanQrCode() async {
    String barcodeScanRes;
    clear(); //clear before new scan
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (barcodeScanRes == '-1') {
        print('Qr code cancelled');
      } else {
        print('QR code scanned: ${barcodeScanRes}');
      }
      qrCode.value = barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
