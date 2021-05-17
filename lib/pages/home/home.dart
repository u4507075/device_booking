import 'package:device_booking/style.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/src/button.dart';
import 'package:device_booking/pages/deviceinfo/devicelist.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UltrasoundStatus()),
                  );
                },
                child: CardButton(
                    'Ultrasound', 'assets/images/ultrasonography.png', 100.0),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UltrasoundStatus()),
                  );
                },
                child: CardButton(
                    'EKG', 'assets/images/electrocardiogram.png', 100.0)),
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
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
