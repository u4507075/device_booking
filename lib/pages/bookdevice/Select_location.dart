import 'dart:async';
import 'package:device_booking/models/pages.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/pages/bookdevice/confirmation.dart';
import 'package:device_booking/pages/bookdevice/qrscan.dart';

class LocationList extends StatefulWidget {


  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item01)
                    )
                );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item02)
                    )
                );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item03)
                    )
                );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item04)
                    )
                );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item05)
                    )
                );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item06)
                    )
                );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item07)
                    )
                );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item08)
                    )
                );},
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
                  }),onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>ConfiPage(place:selectLo.item09)
                  )
              );},
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
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>ConfiPage(place:selectLo.item10)
                    )
                );},
            ),
          ],
        ),
      ),
    );
  }
}