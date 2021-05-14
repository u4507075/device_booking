import 'dart:async';
import 'package:device_booking/models/pages.dart';
import 'package:flutter/material.dart';

class MyApp2 extends StatefulWidget {


  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp2> {
  SelectLoPage selectLo = SelectLoPage();
  StreamController<String> _controller = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    selectLo.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0,
          title: StreamBuilder<Object>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot != null &&
                    snapshot.hasData &&
                    snapshot.data == "success") {
                    print(snapshot);
                    print(snapshot.data);
                    print(selectLo.header);
                  return Text(selectLo.header,);
                } else {
                  return Text('Loading',);
                }
              }),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item01);
                      return Text(selectLo.item01,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item02);
                      return Text(selectLo.item02,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item03);
                      return Text(selectLo.item03,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item04);
                      return Text(selectLo.item04,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item05);
                      return Text(selectLo.item05,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item06);
                      return Text(selectLo.item06,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item07);
                      return Text(selectLo.item07,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item08);
                      return Text(selectLo.item08,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item09);
                      return Text(selectLo.item09,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
            ListTile(
              title: StreamBuilder<Object>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot != null &&
                        snapshot.hasData &&
                        snapshot.data == "success") {
                      print(snapshot);
                      print(snapshot.data);
                      print(selectLo.item10);
                      return Text(selectLo.item10,);
                    } else {
                      return Text('Loading',);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}





//class MyTestBook extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final appTitle = 'Select Location';
//    return MaterialApp(
//      title: appTitle,
//      home: Scaffold(
//        appBar: AppBar(
//          leading: BackButton(),
//          elevation: 0,
//          title: Text(appTitle),
//        ),
//       body: ListView(
//          children: <Widget>[
//            ListTile(
//              //leading: Icon(Icons.map),
//              title: Text('อายุรกรรมชาย 1'),
//            ),
//            ListTile(
//              //leading: Icon(Icons.photo_album),
//              title: Text('อายุรกรรมชาย 2'),
//            ),
//            ListTile(
//              //leading: Icon(Icons.phone),
//              title: Text('อายุรกรรมชาย 3'),
//            ),
//            ListTile(
//              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//            ListTile(
              //leading: Icon(Icons.phone),
//              title: Text('`other`'),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
// item builder + gesture