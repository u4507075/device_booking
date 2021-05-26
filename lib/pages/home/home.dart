import 'package:device_booking/services/auth.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/pages/deviceinfo/devicelist.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/models/user/user.dart';
import 'package:device_booking/models/user/user.dart';
import 'package:device_booking/models/user/user.dart';

//To use UserData copy this!
// import 'package:provider/provider.dart';
// import 'package:device_booking/models/user.dart';

// final user = Provider.of<UserData>(context); //add this below build method

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text.rich(TextSpan(
                  text: 'Welcome,',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '\nUser', //TODO: get name of user
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.normal,
                        ))
                  ],
                )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.account_circle, size: 50.0),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Profile',
                        style: b2TextStyle,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UltrasoundStatus()),
                    );
                  },
                  child: CardButton(
                      'Ultrasound', 'assets/images/ultrasonography.png', 100.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UltrasoundStatus()),
                      );
                    },
                    child: CardButton(
                        'EKG', 'assets/images/electrocardiogram.png', 100.0)),
                ElevatedButton(
                    onPressed: () async {
                      await AuthService().signOut();
                      Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName));
                    },
                    child: Text('Sign out'))
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey[100],
        label: Text('ยืมอุปกรณ์',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        icon: Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/bookdevice/qrscan');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}

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
