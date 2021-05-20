import 'dart:async';
import 'package:device_booking/models/pages.dart';
import 'package:flutter/material.dart';
import 'package:device_booking/pages/bookdevice/confirmation.dart';
import 'package:device_booking/pages/bookdevice/qrscan.dart';

class LocationList extends StatefulWidget {

  String Memail;
  String Mfirstname;
  String MimagePath;
  String Mlastname;
  String Mrole;
  String Mtelephone;
  String qrCode;
  LocationList({Key key, this.qrCode, this.Memail, this.Mfirstname, this.MimagePath, this.Mlastname, this.Mrole, this.Mtelephone}): super(key: key);

  @override
  _LocationListState createState() {
    return _LocationListState(qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone);
  }
}

class _LocationListState extends State<LocationList> {

  String Memail;
  String Mfirstname;
  String MimagePath;
  String Mlastname;
  String Mrole;
  String Mtelephone;
  String qrCode;
  _LocationListState({this.qrCode, this.Memail, this.Mfirstname, this.MimagePath, this.Mlastname, this.Mrole, this.Mtelephone});

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
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
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
                        builder: (context) =>ConfiPage(place:selectLo.item01 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item02 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item03 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item04 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item05 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item06 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item07 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item08 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                      builder: (context) =>ConfiPage(place:selectLo.item09 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
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
                        builder: (context) =>ConfiPage(place:selectLo.item10 , qrCode:qrCode , Memail:Memail , Mfirstname:Mfirstname , MimagePath:MimagePath , Mlastname:Mlastname , Mrole:Mrole , Mtelephone:Mtelephone)
                    )
                );},
            ),
          ],
        ),
      ),
    );
  }
}
