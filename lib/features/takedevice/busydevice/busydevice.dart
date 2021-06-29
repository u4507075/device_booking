import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_booking/core/core.dart';


class BusyDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
          ),
          title: Text('Busy Device'),
          centerTitle: true,
        ),
      ),
    );
  }
}
