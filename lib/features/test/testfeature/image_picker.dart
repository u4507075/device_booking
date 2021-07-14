import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//image = await _picker.getImage(source: ImageSource.gallery);

class ImagePickerTest extends StatefulWidget {
  ImagePickerTest({Key? key}) : super(key: key);

  @override
  _ImagePickerTestState createState() => _ImagePickerTestState();
}

class _ImagePickerTestState extends State<ImagePickerTest> {
  final _picker = ImagePicker();
  PickedFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: (image != null)
                  ? Image.file(File(image!.path))
                  : CircularProgressIndicator(),
            ),
            ElevatedButton(
                onPressed: () async {
                  image = await _picker.getImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: Text('Select an image'))
          ],
        ),
      ),
    );
  }
}
