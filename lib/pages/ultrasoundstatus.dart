import 'dart:ui';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/src/button.dart';
import 'package:device_booking/src/qrfloatingbutton.dart';
import 'package:device_booking/pages/deviceinfo.dart';

class UltrasoundStatus extends StatelessWidget {
  final String _assetPath = "assets/images/ultrasonography.png";
  final String _title = "Ultrasound";
  final List<Device> devices = Device.fetchAll();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, size: 30.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Device Location',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Scrollbar(
              isAlwaysShown: true,
              showTrackOnHover: true,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  // padding: EdgeInsets.all(0.0),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    print(devices[index]);
                    // return Text(devices[index].name);

                    return Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(devices[index].name),
                        subtitle: Text('Location'),
                        leading: Image.asset(
                          _assetPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScanQrCode(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
