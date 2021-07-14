import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './testfeature/testfeature.dart';

class Tester extends StatelessWidget {
  final List<TestFeature> widgets = [
    TestFeature(Tester1(), name: 'Tester 01', description: 'Test Function'),
    TestFeature(ConnectionPlusTest(),
        name: 'Connection Plus Test',
        description: 'Connection Plus for checking connection'),
    TestFeature(FirebaseStorageTest()),
    TestFeature(ProbeLocation()),
    TestFeature(BatteryPlusTest()),
    TestFeature(SensorPlusTest()),
    TestFeature(ImagePickerTest()),
    TestFeature(RealtimeDatabaseTest()),
    TestFeature(AddDevice()),
    TestFeature(QrGenerator()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Feature Tester'),
        ),
        body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return items(widgets[index]);
          },
        ));
  }
}

Widget items(TestFeature widget) {
  return ListTile(
    title: Text(widget.name ?? widget.widget.toString()),
    subtitle: Text(widget.description ?? ''),
    onTap: () => Get.to(() => widget.widget),
  );
}
