import 'package:device_booking/dev/qrscan.dart';
import 'package:device_booking/src/qrfloatingbutton.dart';
import 'package:flutter/material.dart';

class DeviceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Scrollbar(
            isAlwaysShown: true,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: IconButton(
                      icon: Icon(Icons.close, size: 30.0), onPressed: () {}),
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        children: [
                          TableRow(
                            children: [Text('Status'), Text('Location')],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 2.0, 10.0, 2.0),
                                child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration:
                                        BoxDecoration(color: Colors.grey),
                                    child: Text('Available')),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 2.0, 10.0, 2.0),
                                child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration:
                                        BoxDecoration(color: Colors.grey),
                                    child: Text('Here')),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Last use'),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Table(
                          children: [
                            TableRow(
                              children: [Text('User'), Text('Intern Patipan')],
                            ),
                            TableRow(
                              children: [Text('Tel'), Text('091-223-2323')],
                            ),
                            TableRow(
                              children: [Text('Date'), Text('12 May 2021')],
                            ),
                            TableRow(
                              children: [Text('Time'), Text('12.00 - 12.15')],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Problems'),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Text('\n\n\n\n\n\n\n\n\n\n\n\n\n'))
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: ScanQrCode(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

// Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Status'),
//                             Container(
//                               padding: EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(color: Colors.grey),
//                               child: Text('Available'),
//                             )
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Status'),
//                             Container(
//                               padding: EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(color: Colors.grey),
//                               child: Text('Available'),
//                             )
//                           ],
//                         )
//                       ],
//                     )
