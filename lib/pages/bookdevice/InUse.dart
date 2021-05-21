import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_booking/models/pages.dart';
import 'package:device_booking/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_booking/pages/home/home.dart';

class MainPageBusy extends StatefulWidget {
  final FirebaseApp app;
  const MainPageBusy({Key key, this.app}) : super(key: key);

  @override
  _MainPageBusyState createState() => _MainPageBusyState();
}

class _MainPageBusyState extends State<MainPageBusy> {
  InUsePage INUSE = InUsePage();
  StreamController<String> _controller = StreamController.broadcast();
  StreamController<String> _controllerTime = StreamController();

  @override
  void initState() {
    super.initState();
    INUSE.fetchAll(_controller);
    FirebaseDB().getTime(widget.app, _controllerTime, "Sun");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Object>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.hasData &&
                  snapshot.data == "success") {
                return Text(INUSE.ApPbAr, style: TextStyle(fontSize: 28));
              } else {
                return Text('Using Device');
              }
            }),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                StreamBuilder<Object>(
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      if (snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data == "success") {
                        return ElevatedButton(
                            child: Text(INUSE.UppR_LfT_Button),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Report())));
                      } else {
                        return ElevatedButton(
                            child: Text("Report"),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Report())));
                      }
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    child: StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot) {
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Image.network(INUSE.Piggure);
                          } else {
                            return Image.network(
                                'https://device-tracking-system.obs.ap-southeast-2.myhuaweicloud.com/img/device.png');
                          }
                        }),
                  ),
                  Container(
                    //padding: const EdgeInsets.all(10),
                    child: StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot) {
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Text(INUSE.DU_RaTION);
                          } else {
                            return Text('Duration');
                          }
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: StreamBuilder<String>(
                        stream: _controllerTime.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            print(1);
                            return Text(
                              '-- hours -- minutes -- secs',
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }), //duration time
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot) {
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return ElevatedButton(
                              child: Text(INUSE.re),
                              onPressed: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Home(),
                              )),
                            );
                          } else {
                            return ElevatedButton(
                              child: Text("คืนอุปกรณ์"),
                              onPressed: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Home(),
                              )),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 67, 71, 130)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Reported!', style: Theme.of(context).textTheme.headline4);
  }
}

class Back extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 67, 71, 130)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget2(),
        ),
      ),
    );
  }
}

class MyWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Back!', style: Theme.of(context).textTheme.headline4);
  }
}
