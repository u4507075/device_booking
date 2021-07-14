import 'package:get/get.dart';

class LoadingController extends GetxController {
  var _loadingState = false.obs;

  bool get loadingState => _loadingState.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loaded();
  }

  void loading() {
    _loadingState.value = true;
  }

  void loaded() {
    _loadingState.value = false;
  }
}
