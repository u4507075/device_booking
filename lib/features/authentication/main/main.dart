import 'dart:ui';
import './widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/location_hug.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Medical Device\nTracking System',
                      style: Get.textTheme.headline4!
                          .copyWith(color: Get.theme.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "\"Medical Device At Your Fingertip\"",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // LogInWithGoogleButton(),
                  LogInWithPhoneButton(),
                  // signInAnonymousButton(),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Since 2021',
              style: Get.textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
