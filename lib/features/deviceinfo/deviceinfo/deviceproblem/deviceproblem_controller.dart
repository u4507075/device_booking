import 'package:device_booking/features/deviceinfo/deviceinfo/deviceproblem/deviceproblem_model.dart';
import 'package:device_booking/features/deviceinfo/deviceinfo/deviceproblem/deviceproblem_service.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';

class DeviceProblemController extends GetxController {
  var _deviceProblem = DeviceProblem().obs;

  DeviceProblem get problem => _deviceProblem.value;

  Future<int?> count({required Device device}) {
    return DeviceProblemService().fetchCount(device.deviceId);
  }

  Stream<int?>? streamCount({required Device device}) {
    return DeviceProblemService().streamCount(device.deviceId ?? ' ');
  }
}
