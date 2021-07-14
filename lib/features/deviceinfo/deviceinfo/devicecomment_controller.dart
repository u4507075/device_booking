import 'dart:async';

import 'package:device_booking/core/core.dart';
import 'package:device_booking/features/deviceinfo/deviceinfo/devicecomment_model.dart';
import 'package:device_booking/features/deviceinfo/deviceinfo/devicecomment_service.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';

class DeviceCommentController extends GetxController {
  var _deviceComment = DeviceComment().obs;
  var streamGroup = StreamGroup.merge([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initialize();

    // lastUseDevice();
  }

  DeviceComment get comment => _deviceComment.value;

  set commentText(String commentText) {
    _deviceComment.value.setComment = commentText;
  }

  // void set comment()

  void initialize() {
    print('DeviceCommentController initialized');
    _deviceComment.value = DeviceComment(
      comment: '',
      deviceId: Get.find<DeviceController>().device!.deviceId ?? '',
      userId: Get.find<AuthController>().user!.uid,
    );
  }

  Future<void> addComment() {
    return DeviceCommentService().addDeviceComment(_deviceComment.value);
  }

  Future<void> deleteComment() {
    return DeviceCommentService().deleteComment(_deviceComment.value);
  }

  void clearComment() {
    print('comment clear!');
    _deviceComment.value.setComment = '';
  }
}

class DeviceCommentListController extends GetxController {
  Rx<List<DeviceComment?>> _deviceComments = Rx<List<DeviceComment?>>([]);
  String? _deviceId;
  int allCommentNumbers = 0;
  Rx<int> numbers = 5.obs;
  Rx<bool> showedAll = false.obs;

  List<DeviceComment?> get list => _deviceComments.value;
  bool get isAll => showedAll.value;
  int get showedNumbers => numbers.value;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  @override
  void onClose() {
    super.onClose();
    _clear();
  }

  void initialize() {
    print('DeviceCommentListController initialized');
    numbers.value = 5;
    showedAll.value = false;
    bindingStream();
    checkShowedAll();
  }

  void _clear() {
    _deviceComments.value = [];
  }

  void bindingStream() {
    _clear();
    _deviceId = Get.find<DeviceController>().device?.deviceId ?? ' ';
    var stream = DeviceCommentService()
        .streamDeviceComments(_deviceId ?? ' ', numbers: numbers.value)!;
    _deviceComments.bindStream(stream);
    stream.listen((commentList) {
      allCommentNumbers = commentList.length;
      checkShowedAll();
    });
  }

  bool checkShowedAll() {
    (allCommentNumbers < numbers.value)
        ? showedAll.value = true
        : showedAll.value = false;
    print('Showed all comments: ${showedAll.value}');
    return showedAll.value;
  }

  void seeMoreComment() {
    if (!showedAll.value) {
      numbers.value += 5;
      bindingStream();
    }
    checkShowedAll();
  }

  Future<void> fetchDeviceComments() async {
    _deviceComments.value =
        await DeviceCommentService().fetchDeviceComments(_deviceId) ?? [];
  }
}
