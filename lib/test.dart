import 'package:flutter/material.dart';
import 'dart:async';

class MyTestBook extends StatefulWidget {
  MyTestBookState createState() => MyTestBookState();
}

class MyTestBookState extends State<MyTestBook> {
  StreamController<String> _controller = StreamController();
  @override
  void initState() {
    super.initState();
    _controller.add("loading");
  }
  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30.0),
          child: StreamBuilder<String>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return Text('Hello user '+snapshot.data, style: TextStyle(fontSize: 40, color: Colors.white));
            }
            else{
              return Text("Loading");
            }
          }),),
        ElevatedButton(
            onPressed: () {
              _controller.add("My name is cool.");
            },
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Scan QR code', style: TextStyle(fontSize: 40, color: Colors.white)))
        ),
      ],
    );
  }
}


/*class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello, World!',
        style: TextStyle(fontStyle: FontStyle.normal, color: Colors.green));
  }
}

class Book extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30.30),
          child: Text('Hello user', style: TextStyle(fontSize: 55, color: Colors.orange)),
        ),
        ElevatedButton(
          onPressed: () {

          },
          child: Padding(
            padding: EdgeInsets.all(10.10),
            child: Text('Scan QR code', style: TextStyle(fontSize: 35, color: Colors.white)),
          ),
        )
      ],
    );
  }
}*/