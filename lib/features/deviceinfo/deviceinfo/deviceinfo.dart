import 'dart:ui';
import 'package:async/async.dart';
import 'package:device_booking/core/auth/user_service.dart';
import 'package:device_booking/core/device/device_service.dart';
import './viewdevicephoto.dart';
// import './devicecomment/devicecomment.dart';
import 'package:device_booking/features/deviceinfo/devicelist/devicelist_service.dart';
import 'package:device_booking/features/takedevice/qrscan/qrscan.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_booking/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:styled_widget/styled_widget.dart';
import './deviceproblem/deviceproblem.dart';
import 'package:transparent_image/transparent_image.dart';

class DeviceInfo extends StatefulWidget {
  // String? _text;
  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  void unFocus() {
    return FocusManager.instance.primaryFocus?.unfocus();
  }

  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    DeviceController deviceController = Get.put(DeviceController());

    Widget _reportButton() => Container(
          margin: EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/reportproblem',
                    arguments: deviceController.device!.deviceId);
              },
              child: Text('Report'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber, onPrimary: Colors.black),
            ),
          ),
        );

    Color _color;

    deviceController.device!.maintenance!
        ? _color = Colors.yellow[800]!
        : deviceController.device!.inUse!
            ? _color = Colors.red
            : _color = Colors.green;

    Widget moreInfo = PopupMenuButton(
      onSelected: (value) {
        Get.defaultDialog(
          title: 'More Device Info.',
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('DeviceId: ${deviceController.device?.deviceId}'),
              Text('BeaconId: ${deviceController.device?.locatorId}'),
              Container(
                width: Get.size.width / 2,
                height: Get.size.width / 2,
                child: QrImage(
                  data: deviceController.device!.deviceId!,
                  // version: QrVersions.auto,
                  // size: 200.0,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    Get.back();
                    (await saveQrToGallery(
                                deviceController.device!.deviceId!) ??
                            false)
                        ? Get.snackbar('Save an image successful',
                            'Qr code has been save to your gallery')
                        : Get.snackbar('Save an image failed',
                            'Qr An unknown error has occured');
                  },
                  icon: Icon(
                    FontAwesomeIcons.download,
                  ))
            ],
          ),
        );
      },
      itemBuilder: (context) {
        return <PopupMenuItem<String>>[
          PopupMenuItem(value: '123123', child: Text('More info.'))
        ];
      },
      padding: const EdgeInsets.all(0),
      icon: Icon(
        FontAwesomeIcons.ellipsisV,
        color: Colors.black,
        size: 20,
      ),

      // icon: Icon(Icons),
    );

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // backgroundColor: Colors.grey,
        appBar: AppBar(
          leading: Styled.icon(Icons.arrow_back, size: 26)
              .padding(all: 5)
              .decorated(color: Colors.black.withOpacity(0.4))
              .clipOval()
              .gestures(
                onTap: () => Get.back(),
              )
              .padding(all: 5),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () => unFocus(),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ((deviceController.device!.photoURL != null &&
                                  deviceController.device!.photoURL != '')
                              ? FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image:
                                      deviceController.device?.photoURL ?? '',
                                  fadeInDuration: Duration(milliseconds: 300),
                                )
                              : Image.asset(
                                  'assets/images/device_placeholder.png'))
                          .fittedBox(fit: BoxFit.cover)
                          .constrained(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width - 100,
                          )
                          // .backgroundColor(Colors.white)
                          .clipRRect(
                            bottomLeft: 50,
                          )
                          .gestures(onTap: () {
                        //? If there're no device photo -> prevent user to view a placeholder image
                        if (deviceController.device!.photoURL != null &&
                            deviceController.device!.photoURL != '') {
                          Get.dialog(ViewDevicePhoto());
                        }
                      }),
                    ],
                  ),
                  // _reportButton(),
                  [
                    Text(deviceController.device!.deviceType!.capitalize! +
                            ' ' +
                            deviceController.device!.name!)
                        .textStyle(Theme.of(context).textTheme.headline6!)
                        .alignment(Alignment.center),
                    moreInfo.positioned(top: 20, right: 0),
                    Obx(() => Text(deviceController.device!.maintenance!
                            ? 'In maintenance'
                            : (deviceController.device!.inUse!
                                ? 'Busy'
                                : 'Available'))
                        .textStyle(
                            Get.textTheme.bodyText2!.copyWith(color: _color))
                        .alignment(Alignment.bottomCenter)),
                    // .paddingOnly(top: 60),
                  ].toStack().constrained(height: 85).paddingOnly(bottom: 10),
                ]..addAll(deviceController.device!.maintenance!
                    ? []
                    : [
                        LastSeenCard(device: deviceController.device!)
                            .paddingSymmetric(horizontal: 20),
                        CurrentUserCard(device: deviceController.device!)
                            .paddingSymmetric(horizontal: 20),
                        ProblemCard(
                          device: deviceController.device!,
                          onTapDown: () => Get.bottomSheet([
                            ListView(
                              children: [
                                Text('Device Problem Menu',
                                        style: Get.textTheme.bodyText1)
                                    .center()
                                    .constrained(height: 50),
                                Divider(
                                  thickness: 1,
                                ),
                                ListTile(
                                  title: Text(
                                    'Report a device problem',
                                    style: Get.textTheme.bodyText1,
                                  ),
                                  trailing: Icon(FontAwesomeIcons.arrowRight),
                                  onTap: () async {
                                    Get.back();
                                    Get.toNamed('/reportproblem',
                                        arguments:
                                            deviceController.device!.deviceId);
                                  },
                                ),
                              ],
                            ).expanded()
                          ]
                              .toColumn()
                              .decorated(color: Get.theme.canvasColor)
                              .constrained(maxHeight: 200)),
                        ).paddingSymmetric(horizontal: 20),
                        SizedBox(
                          height: 100,
                        )
                      ]),
              ),
            ),
          ),
        ),
        floatingActionButton: qrScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButtonAnimator: ,
      ),
    );
  }
}

class CurrentUserCard extends StatefulWidget {
  CurrentUserCard({Key? key, required this.device}) : super(key: key);
  // CurrentUserCard(this.device);
  final Device device;

  @override
  _CurrentUserCardState createState() => _CurrentUserCardState();
}

class _CurrentUserCardState extends State<CurrentUserCard> {
  bool pressed = false;
  double borderRadius = 30.0;
  // Offset offset = Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    Widget card({required Widget child}) => Styled.widget(child: child)
        .padding(all: 10, animate: true)
        .ripple()
        .backgroundColor(Colors.white, animate: true)
        .clipRRect(all: borderRadius)
        .elevation(pressed ? 0 : 20,
            shadowColor: Color(0x30000000),
            borderRadius: BorderRadius.circular(borderRadius))
        .padding(vertical: 10)
        .gestures(
          onTapChange: (tapStatus) => setState(() {
            pressed = tapStatus;
            print(pressed);
          }),
          onLongPress: () {},
          // onLongPressUp: () =>
          //     launch('tel:${widget.device.lastUserPhoneNumber}'),
          // onTapDown: (details) =>
          //     launch('tel:${widget.device.lastUserPhoneNumber}'),
          onTap: () => (widget.device.lastUserId != '')
              ? launch('tel:${widget.device.lastUserPhoneNumber}')
              : null,
        )
        // .translate(offset: offset, animate: true)
        .scale(all: pressed ? 0.95 : 1, animate: true)
        .animate(Duration(milliseconds: 100), Curves.easeInOutQuad);

    Widget detail = <Widget>[
      Text(widget.device.lastUser!)
          .textStyle(Theme.of(context).textTheme.bodyText2!)
          .padding(
            vertical: 5,
          ),
      Text(widget.device.location!)
          .textStyle(Theme.of(context).textTheme.bodyText2!)
          .padding(
            bottom: 5,
          ),
      Text(formatDateTime(widget.device.lastUseTime))
          .textStyle(Theme.of(context).textTheme.bodyText2!)
          .padding(
            bottom: 5,
          ),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);

    //? Fetch user info and user profile from Firestore
    Widget avatar = FutureBuilder(
      future: UserDataService().fetchUser(
          widget.device.lastUserId == '' ? ' ' : widget.device.lastUserId),
      // initialData: UserData(photoURL: ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String url = (snapshot.data as UserData?)?.photoURL ?? '';
        // print('this is from device Info ' + widget.device.lastUserId! + url);
        return ((url != '')
            ? Image.network(url)
            : Image.asset('assets/images/profile_placeholder.png'));
      },
    )
        .fittedBox(fit: BoxFit.cover)
        .clipOval()
        .padding(all: 10)
        .constrained(width: 80, height: 80, animate: true);

    return card(
        child: <Widget>[
      [
        Styled.text(widget.device.inUse! ? 'Current User' : 'Last User',
                animate: true)
            .textStyle(Theme.of(context).textTheme.bodyText1!)
            .padding(left: 10),
        [
          Styled.icon(
            Icons.call,
            size: Get.textTheme.bodyText1!.fontSize,
          ).padding(right: 10),
          Styled.text('Press to Call', style: Get.textTheme.bodyText1)
              .padding(right: 10),
        ].toRow()
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      Divider(),
      widget.device.lastUserId == ''
          ? <Widget>[
              Text('No previous user')
                  .textStyle(Theme.of(context).textTheme.bodyText2!)
                  .padding(vertical: 10)
            ].toRow(mainAxisAlignment: MainAxisAlignment.center)
          : <Widget>[
              avatar,
              detail,
            ].toRow(mainAxisAlignment: MainAxisAlignment.start)
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start));
  }
}

class LastSeenCard extends StatefulWidget {
  LastSeenCard({Key? key, required this.device}) : super(key: key);

  final Device device;

  @override
  _LastSeenCardState createState() => _LastSeenCardState();
}

class _LastSeenCardState extends State<LastSeenCard> {
  bool pressed = false;
  double borderRadius = 30.0;
  bool searching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget card({required Widget child}) => Styled.widget(child: child)
        .padding(all: 10, animate: true)
        .ripple()
        .backgroundColor(Colors.white, animate: true)
        .clipRRect(all: borderRadius)
        .elevation(pressed ? 0 : 20,
            shadowColor: Color(0x30000000),
            borderRadius: BorderRadius.circular(borderRadius))
        .padding(vertical: 10)
        .gestures(
          onTapChange: (tapStatus) => setState(() {
            pressed = tapStatus;
            print(pressed);
          }),
          // onLongPress: () => launch('tel:${widget.device.lastUserPhoneNumber}'),
          // onLongPressUp: () =>
          //     launch('tel:${widget.device.lastUserPhoneNumber}'),
          // onTapDown: (details) =>
          //     launch('tel:${widget.device.lastUserPhoneNumber}'),
          onTap: () => print('onTap'),
        )
        // .translate(offset: offset, animate: true)
        .scale(all: pressed ? 0.95 : 1, animate: true)
        .animate(Duration(milliseconds: 100), Curves.easeInOutQuad);

    // Widget header = Styled.text('Current user');

    Widget detail = FutureBuilder(
      future: DeviceService().fetchProbeLocation(),
      initialData: {},
      builder: (BuildContext context, AsyncSnapshot probeSnapshot) {
        return StreamBuilder(
          stream:
              Get.find<DeviceController>().streamDeviceLocation(widget.device),
          initialData: DeviceLocation(),
          builder: (BuildContext context, AsyncSnapshot locationSnapshot) {
            Map probeMap = probeSnapshot.data;
            DeviceLocation? deviceLocation = locationSnapshot.data;
            String location = probeMap[deviceLocation?.locationId ?? ''] ?? '';

            deviceLocation != null ? searching = false : searching = true;
            print(searching);
            return <Widget>[
              Text(location)
                  .textStyle(Theme.of(context).textTheme.bodyText2!)
                  .padding(vertical: 5),
              Text(_timeFormat(deviceLocation?.time))
                  .textStyle(Theme.of(context).textTheme.bodyText2!)
                  .padding(
                    bottom: 5,
                  ),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
          },
        );
      },
    );

    Widget icon({required IconData icon}) => Styled.icon(icon, animate: true)
        .iconSize(30)
        .padding(all: 10)
        .constrained(width: 80, animate: true);

    Widget search = Styled.text('Searching')
        .textStyle(Theme.of(context).textTheme.bodyText2!)
        .padding(vertical: 5);

    return StreamBuilder<DeviceLocation>(
        stream:
            Get.find<DeviceController>().streamDeviceLocation(widget.device),
        initialData: DeviceLocation(),
        builder: (context, snapshot) {
          snapshot.data != null ? searching = false : searching = true;
          return card(
              child: <Widget>[
            Styled.text('Last Seen', animate: true)
                .textStyle(Theme.of(context).textTheme.bodyText1!)
                .padding(left: 10),
            Divider(),
            searching
                ? <Widget>[
                    icon(
                      icon: Icons.search,
                    ),
                    search
                  ].toRow()
                : <Widget>[
                    icon(
                      icon: Icons.location_on_rounded,
                    ),
                    detail,
                  ].toRow(mainAxisAlignment: MainAxisAlignment.start)
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start));
        });
  }
}

class ProblemCard extends StatefulWidget {
  ProblemCard({Key? key, required this.device, this.onTapDown})
      : super(key: key);
  // ProblemCard(this.device);
  final Device device;
  final VoidCallback? onTapDown;

  @override
  _ProblemCardState createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
  bool pressed = false;
  double borderRadius = 30.0;
  var controller = Get.put(DeviceProblemController());

  @override
  Widget build(BuildContext context) {
    Widget card({required Widget child}) => Styled.widget(child: child)
        .padding(all: 10, animate: true)
        .ripple()
        .backgroundColor(Colors.white, animate: true)
        .clipRRect(all: borderRadius)
        .elevation(pressed ? 0 : 20,
            shadowColor: Color(0x30000000),
            borderRadius: BorderRadius.circular(borderRadius))
        .padding(vertical: 10)
        .gestures(
          onTapChange: (tapStatus) => setState(() {
            pressed = tapStatus;
            print(pressed);
          }),
          onLongPress: () {},
          // onLongPressUp: () =>
          //     launch('tel:${widget.device.lastUserPhoneNumber}'),
          // onTapDown: (details) =>
          //     launch('tel:${widget.device.lastUserPhoneNumber}'),
          onTap: widget.onTapDown,
        )
        // .translate(offset: offset, animate: true)
        .scale(all: pressed ? 0.95 : 1, animate: true)
        .animate(Duration(milliseconds: 100), Curves.easeInOutQuad);

    Widget detail({required int? count}) => <Widget>[
          Text(count.toString() + ' problem(s) reported')
              .textStyle(Theme.of(context).textTheme.bodyText2!)
              .padding(
                vertical: 5,
              ),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);

    Widget icon({required IconData icon}) => Styled.icon(icon, animate: true)
        .iconSize(30)
        .padding(all: 10)
        .constrained(width: 80, animate: true);

    return card(
        child: <Widget>[
      [
        Styled.text('Problem(s)', animate: true)
            .textStyle(Theme.of(context).textTheme.bodyText1!)
            .padding(left: 10),
        [
          Icon(
            Icons.announcement_rounded,
            size: Get.textTheme.bodyText1!.fontSize,
          ).padding(right: 10),
          Styled.text('Press to report', style: Get.textTheme.bodyText1)
              .padding(right: 10)
        ].toRow(),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      Divider(),
      StreamBuilder<int?>(
        stream: controller.streamCount(device: widget.device),
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          return snapshot.data == 0 || snapshot.data == null
              ? <Widget>[
                  Text('No reported problem')
                      .textStyle(Theme.of(context).textTheme.bodyText2!)
                      .padding(vertical: 10)
                ].toRow(mainAxisAlignment: MainAxisAlignment.center)
              : <Widget>[
                  icon(icon: FontAwesomeIcons.tools),
                  detail(count: snapshot.data),
                ].toRow(mainAxisAlignment: MainAxisAlignment.start);
        },
      ),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start));
  }
}

String formatDateTime(DateTime? time) {
  return time != null ? DateFormat('E, d/MM/yyyy, HH:mm').format(time) : '';
}

String _timeFormat(DateTime? time) {
  var now = DateTime.now();
  String text = '';
  if (time != null) {
    Duration timeLapsed = now.difference(time);

    timeLapsed.compareTo(Duration(minutes: 1)) < 0
        ? text = 'few seconds ago'
        : timeLapsed.compareTo(Duration(hours: 1)) < 0
            ? text = timeLapsed.inMinutes.toString() + ' minute(s) ago'
            : timeLapsed.compareTo(Duration(days: 1)) < 0
                ? text = timeLapsed.inHours.toString() + ' hour(s) ago'
                : timeLapsed.compareTo(Duration(days: 7)) < 0
                    ? text = timeLapsed.inDays.toString() + ' day(s) ago'
                    : text = timeLapsed.inDays.toString() + ' day(s) ago';
    // : timeLapsed.compareTo(Duration(days: 31)) < 0
    //     ? text = timeLapsed.in.toString() + ' week(s) ago'
    //     : text = DateFormat().format(time) + ' month(s) ago';}else{

  }

  return text;
}

// class DeviceInfoCard extends StatefulWidget {
//   // DeviceInfoCard({Key? key}) : super(key: key);
//   DeviceInfoCard(
//       {required this.header, required this.content, this.onLongPressed, this.onTap, this.onTapDown});

//   VoidCallback? onTap;
//   VoidCallback? onTapDown;
//   VoidCallback? onLongPressed;
//   Widget header;
//   Widget content;

//   @override
//   _DeviceInfoCardState createState() => _DeviceInfoCardState();
// }

// class _DeviceInfoCardState extends State<DeviceInfoCard> {
//   bool pressed = false;
//   double borderRadius = 30.0;
//   // Offset offset = Offset(100, 100);

//   @override
//   Widget build(BuildContext context) {
//     Widget card({required Widget child}) => Styled.widget(child: child)
//         .padding(all: 10, animate: true)
//         .ripple()
//         .backgroundColor(Colors.white, animate: true)
//         .clipRRect(all: borderRadius)
//         .elevation(pressed ? 0 : 20,
//             shadowColor: Color(0x30000000),
//             borderRadius: BorderRadius.circular(borderRadius))
//         .padding(vertical: 10)
//         .gestures(
//           onTapChange: (tapStatus) => setState(() {
//             pressed = tapStatus;
//             print(pressed);
//           }),
//           onLongPress: widget.onLongPressed,
//           // onLongPressUp: () =>
//           //     launch('tel:${widget.device.lastUserPhoneNumber}'),
//           // onTapDown: (details) =>
//           //     launch('tel:${widget.device.lastUserPhoneNumber}'),
//           onTap: () => print('onTap'),
//         )
//         // .translate(offset: offset, animate: true)
//         .scale(all: pressed ? 0.95 : 1, animate: true)
//         .animate(Duration(milliseconds: 100), Curves.easeInOutQuad);

//     Widget header = Styled.text('Current user');

//     Widget detail = <Widget>[
//       Text(widget.device.lastUser!)
//           .textStyle(Theme.of(context).textTheme.bodyText2!)
//           .padding(
//             vertical: 5,
//           ),
//       Text(widget.device.location!)
//           .textStyle(Theme.of(context).textTheme.bodyText2!)
//           .padding(
//             bottom: 5,
//           ),
//       Text(formatDateTime(widget.device.lastUseTime))
//           .textStyle(Theme.of(context).textTheme.bodyText2!)
//           .padding(
//             bottom: 5,
//           ),
//     ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);

//     Widget avatar = FutureBuilder(
//       future: UserDataService().fetchUser(
//           widget.device.lastUserId == '' ? ' ' : widget.device.lastUserId),
//       // initialData: UserData(photoURL: ),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         String url = (snapshot.data as UserData?)?.photoURL ?? '';
//         return ((url != '')
//             ? Image.network(url)
//             : Image.asset('assets/images/profile_placeholder.png'));
//       },
//     ).clipOval().padding(all: 10).constrained(width: 80, animate: true);

//     return card(
//         child: <Widget>[
//       Styled.text(widget.device.inUse! ? 'Current User' : 'Last User',
//               animate: true)
//           .textStyle(Theme.of(context).textTheme.bodyText1!)
//           .padding(left: 10),
//       Divider(),
//       widget.device.lastUserId == ''
//           ? <Widget>[
//               Text('No previous user')
//                   .textStyle(Theme.of(context).textTheme.bodyText2!)
//                   .padding(vertical: 10)
//             ].toRow(mainAxisAlignment: MainAxisAlignment.center)
//           : <Widget>[
//               avatar,
//               detail,
//             ].toRow(mainAxisAlignment: MainAxisAlignment.start)
//     ].toColumn(crossAxisAlignment: CrossAxisAlignment.start));
//   }
// }

// var children = <Widget>[
// Obx(() => Text(
//     '${deviceController.device?.deviceType?.capitalize ?? ''} ${deviceController.device?.name?.capitalize ?? ''}',
//     style: Theme.of(context).textTheme.headline3)),
// SizedBox(
//   height: 20.0,
// ),
// Text(
//   'Status',
//   style: Theme.of(context).textTheme.headline3,
// ),
// Container(
//   margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
//   padding: EdgeInsets.all(10.0),
//   alignment: Alignment.center,
//   decoration: BoxDecoration(
//     color: Colors.grey[200],
//     borderRadius: BorderRadius.circular(5.0),
//   ),
//   child: Obx(
//     () {
//       Color _color;

//       deviceController.device!.maintenance!
//           ? _color = Colors.yellow[800]!
//           : deviceController.device!.inUse!
//               ? _color = Colors.red
//               : _color = Colors.green;
//       return Text(
//         '${deviceController.device!.maintenance! ? 'In Maintenance' : !deviceController.device!.inUse! ? 'Available' : 'Busy'}', //TODO: add color
//         style: Theme.of(context)
//             .textTheme
//             .bodyText2!
//             .copyWith(color: _color),
//       );
//     },
//   ),
// ),
// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'Last use',
//   style: Theme.of(context).textTheme.headline3,
// ),
// Container(
//   margin: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
//   padding: EdgeInsets.all(10.0),
//   alignment: Alignment.center,
//   decoration: BoxDecoration(
//     color: Colors.grey[200],
//     borderRadius: BorderRadius.circular(5.0),
//   ),
//   child: Obx(
//     () => Text(
//       '${deviceController.device!.location}',
//       style: Theme.of(context).textTheme.bodyText2,
//     ),
//   ),
// ),

// SizedBox(
//   height: 10.0,
// ),
// Text(
//   'Last seen',
//   style: Theme.of(context).textTheme.headline3,
// ),
// Container(
//   margin: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
//   padding: EdgeInsets.all(10.0),
//   alignment: Alignment.center,
//   decoration: BoxDecoration(
//     color: Colors.grey[200],
//     borderRadius: BorderRadius.circular(5.0),
//   ),
//   child: StreamBuilder(
//     stream: Get.find<DeviceController>().streamProbeLocation(),
//     initialData: {},
//     builder: (BuildContext context, AsyncSnapshot probeSnapshot) {
//       return StreamBuilder(
//         //todo not utilize deviceservice directly
//         stream: DeviceService()
//             .streamLastDeviceLocation(deviceController.device!.deviceId!),
//         initialData: DeviceLocation(),
//         builder: (BuildContext context, AsyncSnapshot locationSnapshot) {
//           DeviceLocation? deviceLocation = locationSnapshot.data;
//           var probeMap = probeSnapshot.data as Map;
//           // print(probeMap.toString());
//           var location = probeMap[deviceLocation?.locationId];
//           return Text(location ?? 'Unknown');
//         },
//       );
//     },
//   ),
// ),

// SizedBox(
//   height: 10.0,
// ),
// Text('Last use', style: Theme.of(context).textTheme.headline3),
// Container(
//   margin: const EdgeInsets.symmetric(vertical: 5),
//   padding: EdgeInsets.all(5.0),
//   decoration: BoxDecoration(
//       color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
//   child: Table(
//     columnWidths: {0: FractionColumnWidth(0.25)},
//     border: TableBorder(
//         horizontalInside:
//             BorderSide(width: 1.0, color: Colors.grey[400]!)),
//     children: [
//       TableRow(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text('User',
//                 style: Theme.of(context).textTheme.bodyText2),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Obx(() => Text('${deviceController.device!.lastUser}',
//                 style: Theme.of(context).textTheme.bodyText2)),
//           ),
//         ],
//       ),
//       TableRow(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text('Tel.',
//                 style: Theme.of(context).textTheme.bodyText2),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: IntrinsicHeight(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Obx(
//                     () {
//                       String? phoneNumber;

//                       (deviceController.device?.lastUserPhoneNumber !=
//                               null)
//                           ? (deviceController.device!.lastUserPhoneNumber!
//                                       .length >
//                                   9)
//                               ? phoneNumber = formatPhoneNumber(
//                                   deviceController
//                                       .device!.lastUserPhoneNumber!)
//                               : phoneNumber = ''
//                           : phoneNumber = '';

//                       return Text('$phoneNumber',
//                           style: Theme.of(context).textTheme.bodyText2);
//                     },
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(0),
//                     height: 20,
//                     child: IconButton(
//                       padding: EdgeInsets.all(0),
//                       onPressed: () {
//                         print(
//                             deviceController.device?.lastUserPhoneNumber);
//                         (deviceController.device?.lastUserPhoneNumber !=
//                                 '')
//                             ? launch(
//                                 'tel:${deviceController.device?.lastUserPhoneNumber}')
//                             : null;
//                       },
//                       icon: Icon(
//                         Icons.phone,
//                         // size: mediumTextSize,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       TableRow(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text('Date',
//                 style: Theme.of(context).textTheme.bodyText2),
//           ),
//           Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Obx(
//                 () => Text(
//                     '${deviceController.device!.lastUseTime != null ? DateFormat('E, d/MM/yyyy').format(deviceController.device!.lastUseTime!) : ''}',
//                     style: Theme.of(context).textTheme.bodyText2),
//               )),
//         ],
//       ),
//       TableRow(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text('Time',
//                 style: Theme.of(context).textTheme.bodyText2),
//           ),
//           Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Obx(
//                 () => Text(
//                     '${deviceController.device!.lastUseTime != null ? DateFormat('HH:mm').format(deviceController.device!.lastUseTime!) : ''}',
//                     style: Theme.of(context).textTheme.bodyText2),
//               )),
//         ],
//       ),
//     ],
//   ),
// ),

// SizedBox(
//   height: 20.0,
// ),
// Divider(),
// // Text('Current User').textStyle(Theme.of(context).textTheme.bodyText1!),

// Divider(),

//? Disable Comment Function here
// Text(
//   'Comments',
//   style: Theme.of(context).textTheme.headline3,
// ),
// addComment(),
// commentList(),
// Center(child: seeMoreComment()),
//   Column(
//     children: [
//       Container(
//         // height: 500,
//         child: ListView(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//         ),
//       ),
//     ],
//   ),
//   // SizedBox(
//   //   height: 100.0, //todo do as in sign up page - single scroll view
//   // )
// ];

// final qrCode = QrCode.fromData(
//     data: deviceController.device?.deviceId ?? '',
//     errorCorrectLevel: QrErrorCorrectLevel.L);
