import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP verification',
      home: Scaffold(
        appBar: AppBar(title: Text('OTP Verification'), centerTitle: true),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'OTP Verification',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Your OTP was sent to 081-2345678'),
            Text('This code will expire in 60 second'),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              SizedBox(
                width: 30,
                height: 40,
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black26, width: 2))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 30,
                height: 40,
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black26, width: 2))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 30,
                height: 40,
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black26, width: 2))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 30,
                height: 40,
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black26, width: 2))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 30,
                height: 40,
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black26, width: 2))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 30,
                height: 40,
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black26, width: 2))),
                ),
              ),
            ]),
            SizedBox(height: 30),
            ElevatedButton(onPressed: () {}, child: Text('Continue')),
            SizedBox(height: 50),
            Text('Resend OTP code')
          ]),
        ),
      ),
    );
  }
}
