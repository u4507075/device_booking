import 'device_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'device_service.dart';
import 'package:device_booking/core/auth/auth.dart';

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
    streamDevice
        .bindStream(DeviceService().streamDevice(_device.value.deviceId));
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
    DeviceService().takeDevice(deviceId, userId, location);
  }

  Future<void> returnDevice({@required String deviceId, String userId}) async {
    DeviceService().returnDevice(deviceId, userId);
  }

  Future<void> reportDevice(
      {@required String deviceId, String userId, String reportText}) async {
    DeviceService().reportDevice(deviceId, userId, reportText);
  }

  Future<void> fetchDevice(String deviceId) {
    return DeviceService().fetchDevice(deviceId).then((device) {
      _device.value = device;
    });
  }

  void setId(String id) {
    _deviceId.value = id;
  }

  void setDevice(Device device) {
    _device.value = device;
  }

  void bindingStream() {
    streamDevice.bindStream(DeviceService().streamDevice(this._deviceId.value));
  }

  Future<void> lastUseDevice() async {
    _device.value = await DeviceService()
        .lastUseDevice(Get.find<AuthController>().user.uid);
  }
}
