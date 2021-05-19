import 'package:device_booking/dev/qrscan.dart';
import 'package:device_booking/src/qrfloatingbutton.dart';
import 'package:flutter/material.dart';


class DeviceInfo extends StatelessWidget {
  final String _status = 'available';
  static const TextStyle _titlestyle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  static const TextStyle _subtitlestyle =
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

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
                  // padding: EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.close, size: 30.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/report');
                            },
                            child: Text('Report'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber, onPrimary: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ), //TODO add image of the device
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
                            children: [
                              Text(
                                'Status',
                                style: _titlestyle,
                              ),
                              Text(
                                'Location',
                                style: _titlestyle,
                              )
                            ],
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
                                    child: Text(_status)),
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
                      Text('Last use', style: _titlestyle),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Table(
                            border: TableBorder(horizontalInside: BorderSide()),
                            children: [
                              TableRow(
                                children: [
                                  Text('User', style: _subtitlestyle),
                                  Text('Intern Patipan')
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text('Tel', style: _subtitlestyle),
                                  Text('091-223-2323')
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text('Date', style: _subtitlestyle),
                                  Text('12 May 2021')
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text('Time', style: _subtitlestyle),
                                  Text('12.00 - 12.15')
                                ],
                              ),
                            ],
                          ),
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
