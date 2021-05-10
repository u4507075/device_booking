import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Report Problem';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation:0,
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(20.0),child:Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 30,
            decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter here',
            ),
          ),
        ButtonWidget(
          text: 'submit',
          onClicked: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => submit()),
            );
          }
          ),
      ],
    ),
      alignment: Alignment.center,
      //width: MediaQuery.of(context).size.width/1,
      //height: MediaQuery.of(context).size.height/1,
    );
  }
}
//---------------------------------------------------
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
class submit extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 61, 76, 100)),
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
    return Text('Submitted!!', style: Theme.of(context).textTheme.headline4);
  }
}
