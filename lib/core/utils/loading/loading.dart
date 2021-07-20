export './loading_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class Loading extends StatelessWidget {
  // const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.primaryColor,
        body: SafeArea(
          child: SpinKitWanderingCubes(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ));
  }
}

class LoadingDialog extends StatelessWidget {
  // const Loading({Key? key}) : super(key: key);
  String? text;
  LoadingDialog({this.text});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SpinKitWanderingCubes(
          color: Colors.white,
          shape: BoxShape.circle,
        )
            .padding(all: 30)
            .constrained(height: 150, width: 150)
            .decorated(color: Color(0xFF333333).withOpacity(0.5))
            .center(),
      ),
    );
  }
}
