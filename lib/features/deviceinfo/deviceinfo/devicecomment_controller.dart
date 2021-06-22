import 'package:device_booking/core/core.dart';
import 'package:device_booking/features/deviceinfo/deviceinfo/devicecomment_model.dart';
import 'package:device_booking/features/deviceinfo/deviceinfo/devicecomment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceCommentController extends GetxController {
  var _deviceComment = DeviceComment().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _deviceComment.value = DeviceComment(
      comment: '',
      deviceId: Get.find<DeviceController>().device.deviceId,
      userId: Get.find<AuthController>().user.uid,
    );
    // lastUseDevice();
  }

  DeviceComment get comment => _deviceComment.value;

  set commentText(String commentText) {
    _deviceComment.value = DeviceComment(comment: commentText);
  }

  // void set comment()

  Future<void> addComment() {
    return DeviceCommentService().addDeviceComment(comment);
  }

  Future<void> deleteComment() {
    return DeviceCommentService().deleteComment(comment);
  }

  void clear() {
    _deviceComment.value = DeviceComment(
      comment: '',
      deviceId: Get.find<DeviceController>().device.deviceId,
      userId: Get.find<UserController>().user.uid,
      // displayName: Get.find<UserController>()
      //     .user
      //     .firstname, //todo fetch new display name to comment
      // userPhotoURL: Get.find<UserController>().user.photoURL,
    );
  }
}

class DeviceCommentListController extends GetxController {
  var _deviceComments = Rxn<List<DeviceComment>>();
  String _deviceId;

  List<DeviceComment> get list => _deviceComments.value;

  @override
  void onInit() {
    super.onInit();
    _deviceId = Get.find<DeviceController>().device?.deviceId ?? '';
    _deviceComments
        .bindStream(DeviceCommentService().streamDeviceComments(_deviceId));
  }

  @override
  void onClose() {
    super.onClose();
    _clear();
  }

  void _clear() {
    _deviceComments.value = [];
  }

  Future<void> fetchDeviceComments() async {
    return _deviceComments.value =
        await DeviceCommentService().fetchDeviceComments(_deviceId);
  }
}
