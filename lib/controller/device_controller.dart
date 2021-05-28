import 'package:device_booking/models/device/device.dart';
import 'package:device_booking/services/database.dart';
import 'package:get/get.dart';

class DeviceController extends GetxController {
  // final device = Device().obs;
  // Rxn<Device> device = Rxn<Device>();
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
  }

  // void setId(String newDeviceId) {
  //   print('set Id');
  //   deviceId = newDeviceId;
  // }
}
