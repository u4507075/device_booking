import 'dart:typed_data';

import 'package:device_booking/features/deviceinfo/devicelist/devicelist_service.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class Tester1 extends StatefulWidget {
  @override
  _Tester1State createState() => _Tester1State();
}

class _Tester1State extends State<Tester1> {
  var userController = Get.put(UserController());

  late TextEditingController textController = TextEditingController();

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200, minHeight: 200),
              child:
                  (image != null) ? Image.memory(image!) : Text('Not found')),
          TextField(
            controller: textController,
            onChanged: (value) => print(textController.text),
          ),
          ElevatedButton(
            onPressed: () async {
              image = await DeviceListService().fetchImage(textController.text);
              setState(() {
                textController.clear();
              });
            },
            child: Text('Find an image'),
          ),
        ],
      )),
    );
  }
}
