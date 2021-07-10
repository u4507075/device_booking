import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset(
              'assets/images/signal_searching.png',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            'No internet connection',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            'Please connect to the internet',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      )),
    );
  }
}
