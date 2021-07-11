import 'package:device_booking/core/device/device_service.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({Key? key}) : super(key: key);

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new device'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text('Add new device'),
            ElevatedButton(
              onPressed: () async {
                Device device = Device(operatingZone: [
                  'ICU Med',
                  'Sub ICU Med',
                  'หอผู้ป่วยอายุรกรรมหญิง 1',
                  'หอผู้ป่วยอายุรกรรมหญิง 2',
                  'หอผู้ป่วยอายุรกรรมหญิง 3',
                  'หอผู้ป่วยอายุรกรรมชาย 1',
                  'หอผู้ป่วยอายุรกรรมชาย 2',
                  'หอผู้ป่วยอายุรกรรมชาย 3',
                  'หอผู้ป่วยพิเศษอายุรกรรมชั้น 14'
                ]);
                DeviceService().addNewDevice(device);
              },
              child: Text('Add new device'),
            )
          ],
        ),
      ),
    );
  }
}
