import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width / 2,
            height: Get.width / 2,
            child: Image.asset(
              'assets/images/signal_searching.png',
              fit: BoxFit.contain,
            ),
          ),
          Text('No internet connection', style: Get.textTheme.headline5)
              .paddingSymmetric(vertical: 10),
          Text(
            'Please connect to the internet',
            style: Get.textTheme.bodyText1,
          ),
        ],
      )),
    );
  }
}
