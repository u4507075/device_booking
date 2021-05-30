import 'package:device_booking/models/device.dart';
import 'package:device_booking/services/database.dart';
import 'package:get/get.dart';

class DeviceController extends GetxController {
  var device = Device().obs;
  String deviceId;

  DeviceController(this.deviceId);
  Device get deviceInfo => device.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('GetX: $deviceId');
    device.bindStream(DBService().streamDevice(deviceId));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  void clear() {
    device.value = Device();
  }
}
