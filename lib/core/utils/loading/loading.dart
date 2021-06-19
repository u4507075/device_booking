export './loading_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingArgument {
  Function function;
  LoadingArgument({this.function});
}

class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: SafeArea(
          child: SpinKitWanderingCubes(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ));
  }
}
