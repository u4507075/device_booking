import 'package:flutter/material.dart';
import 'package:device_booking/models/user/user.dart';

class InheritedUserData extends InheritedWidget {
  InheritedUserData({Key key, this.child, this.user})
      : super(key: key, child: child);

  final Widget child;
  final UserData user;

  static InheritedUserData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedUserData>();
  }

  @override
  bool updateShouldNotify(InheritedUserData oldWidget) {
    return oldWidget.user != user;
  }
}
