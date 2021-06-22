import 'package:device_booking/core/core.dart';
import './devicelist_service.dart';
import 'package:get/get.dart';

class DeviceListController extends GetxController {
  var deviceList = Rxn<List<Device>>();
  String deviceType;

  DeviceListController(this.deviceType);
  List<Device> get list => deviceList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('GetX: $deviceType');
    deviceList.bindStream(DeviceListService().streamDeviceList(deviceType));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clear();
  }

  void clear() {
    deviceList.value = [];
  }
}
