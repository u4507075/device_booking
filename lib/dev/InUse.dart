import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/models/pages.dart';


class MainPageBusy extends StatefulWidget {

  @override
  _MainPageBusyState createState() => _MainPageBusyState();
}

class _MainPageBusyState extends State<MainPageBusy> {


  InUsePage INUSE = InUsePage();
  StreamController<String> _controller = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    INUSE.fetchAll(_controller);

  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  var appBar = AppBar(
    title: Text("In Use", style: TextStyle(fontSize: 28)),
    centerTitle: true,
  );
  Widget build(BuildContext context) => Scaffold(
    appBar: appBar,
    body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ButtonWidget(
                    text: 'Report', //สร้างปุ่ม+copy to clipboard
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Report(),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height) /
                    20,
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
                      child: Image.network(
                          'https://device-tracking-system.obs.ap-southeast-2.myhuaweicloud.com/img/device.png'),
                    ),
                    Container(
                      //padding: const EdgeInsets.all(10),
                      child: Text(
                        'Duration',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: StreamBuilder<String>(
                          stream: _controller.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData){
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            else{
                              return Text(
                                '-- hours -- minutes',
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }

                          }),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: ButtonWidget(
                          text: 'คืนอุปกรณ์', //สร้างปุ่ม+copy to clipboard
                          onClicked: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Back(),
                              )),
                        )),
                  ],
                ),
              ),
            ],
          ),
        )),
  );
}


//buttonwidget
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    @required this.text,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
    shape: StadiumBorder(),
    color: Theme.of(context).primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textColor: Colors.white,
    onPressed: onClicked,
  );
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

// Future <String> fetchData() async {
//   String userid = '300da4192f5db344';
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   DocumentSnapshot documentSnapshot = await users.doc(userid).get();
//
//   if(documentSnapshot.exists){
//     Map<String, dynamic> data = documentSnapshot.data();
//     String datetime = data["date"];
//     var dateTime1 = DateFormat('yyyy-MM-dd hh:mm:ss').parse(datetime);
//     final hrs = DateTime.now().difference(dateTime1).inHours;
//     final mins = DateTime.now().difference(dateTime1).inMinutes;
//     final secs = DateTime.now().difference(dateTime1).inSeconds;
//     int min = mins%60;
//     int sec = secs%60;
//     return '$hrs hours $min minutes $sec secs';
//   }
// }