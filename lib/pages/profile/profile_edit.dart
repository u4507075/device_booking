import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_booking/style.dart';
import 'package:device_booking/widget/profile_widget.dart';
import 'package:device_booking/models/user.dart';
import 'package:provider/provider.dart';

class ProfilePageEdit extends StatefulWidget{
  @override
  _ProfilePageEditState createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {

  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0.0,
          title: Text(
            'Profile',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileWidget(
                imagePath: user.photoURL,
              ),
              const SizedBox(height: 20),

            ],
          ),
        )
    );
  }
}