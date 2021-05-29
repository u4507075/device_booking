import 'dart:async';
import 'package:device_booking/controller/device_controller.dart';
import 'package:device_booking/models/device.dart';
import 'package:device_booking/models/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/pages/bookdevice/confirmation.dart';
import 'package:device_booking/pages/bookdevice/qrscan.dart';
import 'package:get/get.dart';

class SelectLocation extends StatelessWidget {
  // const SelectLocation({Key key}) : super(key: key);
  List<dynamic> operatingZone =
      Get.find<DeviceController>().deviceInfo.operatingZone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        title: Text('Select location'),
      ),
      body: ListView.builder(
        itemCount: operatingZone.length,
        itemBuilder: (context, index) {
          return _location(operatingZone[index]);
        },
      ),
    );
  }
}

Widget _location(String location) {
  return ListTile(
    title: Text('$location'),
    onTap: () {
      Get.toNamed('/confirmation', arguments: location);
    },
  );
}

// class LocationList extends StatefulWidget {
//   String Memail;
//   String Mfirstname;
//   String MimagePath;
//   String Mlastname;
//   String Mrole;
//   String Mtelephone;
//   String qrCode;
//   String myID;
//   LocationList(
//       {Key key,
//       this.myID,
//       this.qrCode,
//       this.Memail,
//       this.Mfirstname,
//       this.MimagePath,
//       this.Mlastname,
//       this.Mrole,
//       this.Mtelephone})
//       : super(key: key);

//   @override
//   _LocationListState createState() {
//     return _LocationListState(
//         myID: myID,
//         qrCode: qrCode,
//         Memail: Memail,
//         Mfirstname: Mfirstname,
//         MimagePath: MimagePath,
//         Mlastname: Mlastname,
//         Mrole: Mrole,
//         Mtelephone: Mtelephone);
//   }
// }

// class _LocationListState extends State<LocationList> {
//   String Memail;
//   String Mfirstname;
//   String MimagePath;
//   String Mlastname;
//   String Mrole;
//   String Mtelephone;
//   String qrCode;
//   String myID;
//   _LocationListState(
//       {this.myID,
//       this.qrCode,
//       this.Memail,
//       this.Mfirstname,
//       this.MimagePath,
//       this.Mlastname,
//       this.Mrole,
//       this.Mtelephone});

//   SelectLoPage selectLo = SelectLoPage();
//   StreamController<String> _controller = StreamController.broadcast();

//   @override
//   void initState() {
//     super.initState();
//     selectLo.fetchAll(_controller);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.pushNamed(context, '/bookdevice/qrscan');
//             },
//           ),
//           elevation: 0,
//           title: StreamBuilder<Object>(
//               stream: _controller.stream,
//               builder: (context, snapshot) {
//                 if (snapshot != null &&
//                     snapshot.hasData &&
//                     snapshot.data == "success") {
//                   return Text(
//                     selectLo.header,
//                   );
//                 } else {
//                   return Text(
//                     'Loading',
//                   );
//                 }
//               }),
//         ),
//         body: ListView(
//           children: <Widget>[
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item01,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item01,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item02,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item02,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item03,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item03,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item04,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item04,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item05,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item05,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item06,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item06,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item07,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item07,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item08,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item08,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item09,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item09,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//             ListTile(
//               title: StreamBuilder<Object>(
//                   stream: _controller.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot != null &&
//                         snapshot.hasData &&
//                         snapshot.data == "success") {
//                       return Text(
//                         selectLo.item10,
//                       );
//                     } else {
//                       return Text(
//                         'Loading',
//                       );
//                     }
//                   }),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfiPage(
//                             place: selectLo.item10,
//                             myID: myID,
//                             qrCode: qrCode,
//                             Memail: Memail,
//                             Mfirstname: Mfirstname,
//                             MimagePath: MimagePath,
//                             Mlastname: Mlastname,
//                             Mrole: Mrole,
//                             Mtelephone: Mtelephone)));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
