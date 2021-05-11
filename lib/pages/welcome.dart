import 'package:flutter/material.dart';
import 'package:device_booking/src/button.dart';

class Welcome extends StatelessWidget {
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
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.account_circle, size: 50.0),
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  CardButton(
                      'Ultrasound', 'assets/images/ultrasonography.png', 100.0),
                  SizedBox(
                    height: 5.0,
                  ),
                  CardButton(
                      'EKG', 'assets/images/electrocardiogram.png', 100.0),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 9.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 0),
                    )
                  ]),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: ListTile(
                      leading: Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Scan QR Code',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                    ),
                  ),
                ))));
  }
}

// Container(
//           height: 100.0,
//           decoration: BoxDecoration(
//             color: Colors.blue,
//           ),
//           child: ListTile(
//             leading: Icon(
//               Icons.qr_code_rounded,
//               size: 70.0,
//               color: Colors.white,
//             ),
//             title: Text(
//               'Scan QR Code',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24.0),
//             ),
//             subtitle: Text(
//               'เพื่อยืมอุปกรณ์',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal,
//                   fontSize: 20.0),
//             ),
//           ),
//         ),
