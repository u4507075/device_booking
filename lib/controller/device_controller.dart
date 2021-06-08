import 'package:device_booking/controller/auth_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceController extends GetxController {
  var streamDevice = Device().obs;
  var _device = Device().obs;
  var _deviceId = ''.obs;

  Device get deviceInfo => streamDevice.value;

  Device get device => _device.value;

  String get id => _deviceId.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    streamDevice.bindStream(DBService().streamDevice(_device.value.deviceId));
    // lastUseDevice();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  void clear() {
    streamDevice.value = Device();
  }

  Future<void> takeDevice(
      {@required String deviceId,
      @required String userId,
      @required String location}) async {
    DBService().takeDevice(deviceId, userId, location);
  }

  Future<void> returnDevice({@required String deviceId, String userId}) async {
    DBService().returnDevice(deviceId, userId);
  }

  Future<void> reportDevice(
      {@required String deviceId, String userId, String reportText}) async {
    DBService().reportDevice(deviceId, userId, reportText);
  }

  Future<void> fetchDevice(String deviceId) {
    return DBService().fetchDevice(deviceId).then((device) {
      _device.value = device;
    });
  }

  void setId(String id) {
    _deviceId.value = id;
  }

  void setDevice(Device device) {
    _device.value = device;
  }

  Future<void> lastUseDevice() async {
    _device.value = await DBService()
        .lastUseDevice(Get.find<AuthController>().firebaseUser.uid);
  }
}
