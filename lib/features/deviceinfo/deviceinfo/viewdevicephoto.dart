import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:device_booking/core/core.dart';
import 'package:transparent_image/transparent_image.dart';

class ViewDevicePhoto extends StatelessWidget {
  ViewDevicePhoto({Key? key}) : super(key: key);
  final DeviceController deviceController = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Styled.icon(Icons.close, size: 26)
            .padding(all: 5)
            .decorated(color: Colors.black.withOpacity(0.4))
            .clipOval()
            .gestures(
              onTap: () => Get.back(),
            )
            .padding(all: 5),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: InteractiveViewer(
          // boundaryMargin: const EdgeInsets.all(100),
          child: Container(
        height: Get.height,
        child: ((deviceController.device!.photoURL != null &&
                    deviceController.device!.photoURL != '')
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: deviceController.device?.photoURL ?? '',
                    fadeInDuration: Duration(milliseconds: 300),
                  )
                : Image.asset('assets/images/device_placeholder.png'))
            .fittedBox(fit: BoxFit.fitWidth),
      )).center(),
      backgroundColor: Get.theme.shadowColor,
    );
  }
}
