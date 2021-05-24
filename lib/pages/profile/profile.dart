import 'package:device_booking/models/user.dart';
import 'package:device_booking/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/style.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/models/pfpages.dart';
import 'package:device_booking/models/user_page.dart';
import 'package:device_booking/pages/loading.dart';
import 'package:device_booking/pages/profile/profile_edit.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Userpager usr = Userpager();
  Profilepager pfp = Profilepager();
  StreamController<String> _controller = StreamController.broadcast();
  StreamController<String> _ucontroller = StreamController.broadcast();
  final databaseReference = FirebaseFirestore.instance;
  String valueChoose;

  @override
  void initState() {
    super.initState();
    pfp.fetchAll(_controller);
    usr.fetchAll(_ucontroller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamBuilder<Object>(
        stream: _ucontroller.stream,
        builder: (context, snapshot) {
          if (snapshot != null &&
              snapshot.hasData &&
              snapshot.data == "success"){
            return Scaffold(
                appBar: AppBar(
                  leading: BackButton(),
                  elevation: 0.0,
                  title: Text(
                    'Profile',
                    style: appBarTextStyle,
                  ),
                  centerTitle: true,
                  actions: [
                    Align(
                      alignment: Alignment (0, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: InkWell(
                          onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ProfilePageEdit()),
                              );
                          },
                          child: Text(pfp.button1, textAlign: TextAlign.center, style: appBarTextStyle),
                        ),
                      ),
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ProfileWidget(
                        imagePath: usr.imagePath,
                      ),
                      const SizedBox(height: 20),
                      Text(usr.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(user.uid, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 20),
                      //FirstNameBox
                      Row(
                        children: [
                          Container(
                            color: Colors.red,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child: Text(pfp.text1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child:
                            Text(usr.firstname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                        ],
                      ),
                      Divider(thickness: 0.2, color: Colors.black,),
                      //LastNameBox
                      Row(
                        children: [
                          Container(
                            color: Colors.red,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child: Text(pfp.text2, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child:
                            Text(usr.lastname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                        ],
                      ),
                      Divider(thickness: 0.2, color: Colors.black,),
                      //TelephoneBox
                      Row(
                        children: [
                          Container(
                            color: Colors.red,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child: Text(pfp.text3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child:
                            Text(usr.telephone, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                        ],
                      ),
                      Divider(thickness: 0.2, color: Colors.black,),
                      //RoleBox
                      //TODO implement role choose dropdown selection
                      Row(
                        children: [
                          Container(
                            color: Colors.red,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child: Text(pfp.text4, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child:
                            Text(usr.role, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                        ],
                      ),
                    ],
                  ),
                )
            );
          } else {
            return Loading();
          }
        }
    );
  }
}
