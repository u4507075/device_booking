import 'package:device_booking/core/auth/user.dart';

import 'device_model.dart';
import 'package:get/get.dart';
import 'device_service.dart';
import 'package:device_booking/core/auth/auth.dart';

class DeviceController extends GetxController {
  var streamDevice = Device().obs;
  Rx<Device?> _device = Device().obs;
  var _deviceId = ''.obs;
  // var streamDeviceLocation = DeviceLocation().obs;
  var user = Get.find<UserController>().user;

  // var locationDict = {}.obs;

  Device? get deviceInfo => streamDevice.value;

  Device? get device => _device.value;

  String get id => _deviceId.value;

  // DeviceLocation get value => streamDeviceLocation.value;

  @override
  void onInit() {
    super.onInit();
    streamDevice.bindStream(
        DeviceService().streamDevice(_device.value!.deviceId ?? ' ')!);
    // locationDict.bindStream(DeviceService().streamProbeLocaiton());
    // DeviceService().streamProbeLocaiton().listen((map) {

    // });

    // streamDeviceLocation.bindStream(DeviceService().streamLastDeviceLocation());
    // var user = Get.find<UserController>().user;
    // lastUseDevice();
  }

  @override
  void onClose() {
    //
    super.onClose();
    clear();
  }

  void init() {}

  void clear() {
    streamDevice.value = Device();
  }

  Future<void> takeDevice(
      {required Device device,
      required UserData user,
      required String location}) async {
    DeviceService().takeDevice(device, user, location);
  }

  Future<void> returnDevice({required Device device, String? userId}) async {
    DeviceService()
        .returnDevice(device, Get.find<AuthController>().firebaseUser!.uid);
  }

  Future<void> reportDevice(
      {required Device device,
      required UserData user,
      required String reportText}) async {
    DeviceService().reportDevice(device, user, reportText);
  }

  Future<void> fetchDevice(String? deviceId) {
    return DeviceService().fetchDevice(deviceId).then((device) {
      _device.value = device;
    });
  }

  void setId(String id) {
    _deviceId.value = id;
  }

  void setDevice(Device? device) {
    _device.value = device;
  }

  void bindingStream() {
    streamDevice.bindStream(
        DeviceService().streamDevice(this._device.value!.deviceId ?? ' ')!);
  }

  Future<void> lastUseDevice() async {
    _device.value = await DeviceService()
        .lastUseDevice(Get.find<AuthController>().user!.uid);
  }

  Stream<DeviceLocation>? streamDeviceLocation(Device device) {
    return DeviceService().streamDeviceLocation(device.deviceId ?? ' ');
  }

  Stream<Map<String, dynamic>>? streamProbeLocation() {
    return DeviceService().streamProbeLocation();
  }
}
