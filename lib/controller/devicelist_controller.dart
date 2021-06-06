import 'package:device_booking/models/device.dart';
import 'package:device_booking/services/database.dart';
import 'package:get/get.dart';

class DeviceListController extends GetxController {
  Rxn<DeviceList> deviceList = Rxn<DeviceList>();
  String deviceType;

  DeviceListController(this.deviceType);
  DeviceList get value => deviceList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('GetX: $deviceType');
    deviceList.bindStream(DBService().streamDeviceList(deviceType));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  void clear() {
    deviceList.value = DeviceList();
  }
}
