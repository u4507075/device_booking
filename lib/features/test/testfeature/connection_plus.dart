import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'package:stream_transform/stream_transform.dart';

class ConnectionPlusTest extends StatefulWidget {
  // const ConnectionPlusTest({Key? key}) : super(key: key);

  @override
  _ConnectionPlusTestState createState() => _ConnectionPlusTestState();
}

class _ConnectionPlusTestState extends State<ConnectionPlusTest> {
  StreamSubscription? subscription;
  String connectionStatus = '';

  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        connectionStatus = result.toString();
        print('Connection status changed!: ${result.toString()}');
      });
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();

    subscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Plus Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text('${snapshot.data}');
              },
            ),
            FutureBuilder(
                future: Connectivity().checkConnectivity(),
                builder: (context, snapshot) {
                  return Text('${snapshot.data}');
                }),
            StreamBuilder(
              stream: internetConnection(),
              initialData: [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                return Text(snapshot.data.toString());
              },
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Refresh'))
          ],
        ),
      ),
    );
  }
}

Stream<bool> internetConnection() async* {
  try {
    yield* InternetAddress.lookup('example.com')
        .asStream()
        .map((e) => e.isNotEmpty && e[0].rawAddress.isNotEmpty ? true : false);
  } on SocketException catch (_) {
    yield false;
  }
  // yield false;
}
