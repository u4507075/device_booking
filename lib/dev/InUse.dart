import 'package:flutter/material.dart';
import 'package:device_booking/dev/date time.dart';

void main() {
  runApp(Busy());
}

//สร้างหัวข้อ+ธีม
class Busy extends StatelessWidget {
  static final String title = 'Using device';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: Color.fromARGB(255, 218, 105, 98),
      scaffoldBackgroundColor: Colors.white,
    ),
    home: MainPage(title: title),
  );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  var appBar = AppBar(
    title: Text(Busy.title, style: TextStyle(fontSize: 28)),
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
                    10,
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
                      padding: const EdgeInsets.all(15),
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
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '$hrs hours $min minutes',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(25),
                        child: ButtonWidget(
                          text: 'คืนอุปกรณ์', //สร้างปุ่ม+copy to clipboard
                          onClicked: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Back(),
                              )),
                        ))
                  ],
                ),
              ),
            ],
          ),
        )),
  );
}
//buttonwidget

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
