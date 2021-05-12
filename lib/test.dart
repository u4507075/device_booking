import 'package:flutter/material.dart';

class MyTestBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Select Location';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0,
          title: Text(appTitle),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              //leading: Icon(Icons.map),
              title: Text('อายุรกรรมชาย 1'),
            ),
            ListTile(
              //leading: Icon(Icons.photo_album),
              title: Text('อายุรกรรมชาย 2'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('อายุรกรรมชาย 3'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
            ListTile(
              //leading: Icon(Icons.phone),
              title: Text('`other`'),
            ),
          ],
        ),
      ),
    );
  }
}
// item builder + gesture