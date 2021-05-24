import 'package:device_booking/models/Userdetail.dart';
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
import 'package:device_booking/services/firebasedb.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // Userpager usr = Userpager();
  Profilepager pfp = Profilepager();
  StreamController<String> _controller = StreamController.broadcast();
  final databaseReference = FirebaseFirestore.instance;
  String valueChoose;

  String Memail;
  String Mfirstname;
  String MimagePath;
  String Mlastname;
  String Mrole;
  String Mtelephone;
  UserDetails userdetails;
  String myID = 'myID';

  @override
  void initState() {
    super.initState();
    pfp.fetchAll(_controller);
    // FirebaseDB().fetchUserDetails(myID).then((value) =>
    // this.userdetails = value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return FutureBuilder(
        future: FirebaseDB().fetchUserDetails(myID),
     builder: (BuildContext context, AsyncSnapshot usr) {
    if (usr.hasData) {
       // print(usr.data.firstname);
       print(1);
    return StreamBuilder<Object>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (snapshot != null &&
              snapshot.hasData &&
              snapshot.data == "success"){
            print(3);
            print(snapshot.data);
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
                        imagePath: user.photoURL,
                      ),
                      const SizedBox(height: 20),
                      Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                            Text(usr.data.firstname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
                            Text('Lname', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
                            Text('Telephone', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
                            Text('Role', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            );
          } else {
            print(4);
            return Loading();
          }
        }
    )
    ;
    } else {
      print('2');
      return Loading();
    }
        }

    );
  }


  }

