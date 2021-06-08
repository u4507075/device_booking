import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/style.dart';
import 'package:device_booking/widget/qrscanbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//To use UserData copy this!
// import 'package:provider/provider.dart';
// import 'package:device_booking/models/user.dart';

// final user = Provider.of<UserData>(context); //add this below build method

class Home extends StatelessWidget {
  @override

  // Get.put(UserController());
  Widget build(BuildContext context) {
    // final user = context.watch<UserData>();
    UserController controller = Get.put(UserController());
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Obx(
                  () => Text(
                      'Welcome,\n${Get.find<UserController>().streamUser?.firstname}',
                      style: h1TextStyle),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed('/profile');
                  },
                  icon: Icon(Icons.account_circle_sharp),
                  iconSize: 60,
                ),
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: <Widget>[
                //     Icon(Icons.account_circle, size: 50.0),
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: Text(
                //         'Profile',
                //         style: b2TextStyle,
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'I want to know location of ...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView(children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/devicelist', arguments: 'ultrasound');
                  },
                  child: CardButton(
                      'Ultrasound', 'assets/images/ultrasonography.png', 100.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed('/devicelist', arguments: 'ekg');
                    },
                    child: CardButton(
                        'EKG', 'assets/images/electrocardiogram.png', 100.0)),
                // ElevatedButton(
                //     onPressed: () async {
                //       await AuthService().signOut();
                //       // Navigator.popUntil(context,
                //       //     ModalRoute.withName(Navigator.defaultRouteName));
                //     },
                //     child: Text('Sign out')),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: _qrScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}

Widget _qrScanButton() => qrScanButton();

class CardButton extends StatelessWidget {
  static const double _edge = 10.0;
  static const double _elevation = 3.0;
  final double _height;
  final String _assetPath;
  final String _title;

  CardButton(this._title, this._assetPath, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: _elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_edge)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: _height,
                alignment: Alignment.center,
                child: ListTile(
                  leading: LoadingImageContain(_assetPath, 60.0),
                  title: Text(
                    _title,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  // subtitle: Text('Subtitle'),
                  isThreeLine: false,
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class LoadingImageContain extends StatelessWidget {
  final _assetPath;
  final _maxSize;

  LoadingImageContain(this._assetPath, this._maxSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: _maxSize),
      child: Image.asset(
        _assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
