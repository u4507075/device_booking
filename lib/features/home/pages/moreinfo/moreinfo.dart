import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void moreInfo(BuildContext context) async {
  return await PackageInfo.fromPlatform()
      .then(
    (info) => showAboutDialog(
      context: context,
      applicationName: 'MedTrack',
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/images/app_icon.png',
        fit: BoxFit.cover,
        height: 50,
        width: 50,
        filterQuality: FilterQuality.high,
      ).clipRRect(all: 10).elevation(
            2,
            borderRadius: BorderRadius.circular(10),
            shadowColor: Color(0xD9D9D9D9),
          ),
    ),
  )
      .onError((error, stackTrace) {
    Get.snackbar('MedTrack', error.toString());
    print(stackTrace);
  });
}
