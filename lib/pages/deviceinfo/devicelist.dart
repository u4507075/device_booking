import 'dart:ui';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/src/button.dart';
import 'package:device_booking/src/qrfloatingbutton.dart';
import 'package:device_booking/pages/deviceinfo/deviceinfo.dart';

class UltrasoundStatus extends StatefulWidget {
  @override
  _UltrasoundStatusState createState() => _UltrasoundStatusState();
}

class _UltrasoundStatusState extends State<UltrasoundStatus> {
  final String _assetPath = "assets/images/ultrasonography.png";
  List<Device> devices;

  @override
  void initState() {
    super.initState();
    devices = Device.fetchAll();
  }

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
                  padding: EdgeInsets.all(5.0),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    print(devices[index]);
                    return deviceStatus(
                        name: devices[index].name, type: devices[index].type);
                    // return Text(devices[index].name);
                    // return CardStatus(
                    //   name: devices[index].name,
                    //   type: 'ultrasound',

                    // return Card(
                    //   child: ListTile(
                    //     onTap: () {},
                    //     title: Text(devices[index].name),
                    //     subtitle: Text('Location'),
                    //     leading: Image.asset(
                    //       _assetPath,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // );
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

Widget deviceStatus({String name, String type}) {
  String assetPath;
  if (type == 'ultrasound') {
    assetPath = "assets/images/ultrasonography.png";
  } else if (type == 'ekg') {
    assetPath = "assets/images/electrocardiogram.png";
  }
  return CardStatus(name: name, type: type, assetPath: assetPath);
}

class CardStatus extends StatelessWidget {
  const CardStatus({Key key, this.name, this.type, this.assetPath})
      : super(key: key);
  final String name;
  final String type;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: Text(name),
        subtitle: Text('Location'),
        leading: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
