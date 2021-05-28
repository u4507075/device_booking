import 'dart:ui';
import 'package:device_booking/models/device/device.dart';
import 'package:device_booking/models/device/device2.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/src/qrfloatingbutton.dart';
import 'package:provider/provider.dart';

// class DeviceListPageWrapper extends StatelessWidget {
//   const DeviceListPageWrapper({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<DeviceList>(
//       create: (context) => DeviceList().streamUltrasoundDeviceList(),
//       initialData: DeviceList.initialValue(),
//       child: DeviceListPage(),
//     );
//   }
// }

class DeviceListPage extends StatefulWidget {
  DeviceListPage({Key key, String deviceType}) : super(key: key);
  String deviceType; //Recieve from card button (select device type)

  @override
  _DeviceListPageState createState() =>
      _DeviceListPageState(deviceType: deviceType);
}

class _DeviceListPageState extends State<DeviceListPage> {
  // DeviceList _devices;
  String deviceType;

  _DeviceListPageState({this.deviceType});

  @override
  void initState() {
    super.initState();
    // DeviceList().fetchDeviceList(deviceType).then;
  }

  @override
  Widget build(BuildContext context) {
    final ultrasoundDeviceList = Provider.of<UltrasoundDeviceList>(context);
    final ekgDeviceList = Provider.of<EkgDeviceList>(context);
    List<Device> ultrasounddevices = ultrasoundDeviceList.devices;
    List<Device> ekgdevices = ekgDeviceList.devices;
    List<Device> devices;
    Map map = ModalRoute.of(context).settings.arguments;
    deviceType = map['deviceType'];

    if (deviceType == 'ultrasound') {
      devices = ultrasounddevices;
    } else if (deviceType == 'ekg') {
      devices = ekgdevices;
    } else {
      devices = [];
    }

    print(deviceType);

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
                        name: devices[index].name,
                        type: devices[index].deviceType,
                        location: devices[index].location);
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

Widget deviceStatus({String name, String type, String location}) {
  String assetPath;
  if (type == 'ultrasound') {
    assetPath = "assets/images/ultrasonography.png";
  } else if (type == 'ekg') {
    assetPath = "assets/images/electrocardiogram.png";
  }
  return CardStatus(
      name: name, type: type, assetPath: assetPath, location: location);
}

class CardStatus extends StatelessWidget {
  const CardStatus(
      {Key key, this.name, this.type, this.assetPath, this.location})
      : super(key: key);
  final String name;
  final String type;
  final String assetPath;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: Text(name),
        subtitle: Text(location ?? ''),
        leading: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
