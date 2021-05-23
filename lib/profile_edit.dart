import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/models/user_page.dart';
import 'package:device_booking/models/pages.dart';
import 'package:device_booking/user/user_pref.dart';
import 'package:device_booking/widget/appbar_widget.dart';
import 'package:device_booking/widget/profile_widget.dart';
import 'package:device_booking/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_booking/user/user.dart';



class ProfilePageEdit extends StatefulWidget{
  @override
  _ProfilePageEditState createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {

  Userpager usr = Userpager();
  Profilepager pfp = Profilepager();
  StreamController<String> _controller = StreamController.broadcast();
  StreamController<String> _ucontroller = StreamController.broadcast();
  final databaseReference = FirebaseFirestore.instance;

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
    final user = UserPreferences.myUser;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: (
            Column(
              children: <Widget>[
                //image
                StreamBuilder<Object>(
                    stream: _ucontroller.stream, // Known Bug is when use _contoller.stream it still works lol?!?!?
                    builder: (context, snapshot){
                      if (snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data == "success") {
                        return ProfileWidget(imagePath: usr.imagePath,);
                      } else {
                        return ProfileWidget(imagePath: user.imagePath,);
                      }
                    }),
               const SizedBox(height: 20),
                //Email
                StreamBuilder<Object>(
                    stream: _ucontroller.stream, // Known Bug is when use _contoller.stream it still works lol?!?!?
                    builder: (context, snapshot){
                      if (snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data == "success") {
                        return Text(usr.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18));
                      } else {
                        return buildName(user);
                      }
                    }),
               //SaveButton
                StreamBuilder<Object>(
                    stream: _controller.stream,
                    builder: (context, snapshot){
                      if (snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data == "success") {
                        return Align(
                            alignment: Alignment(0.8, 0.5),
                            child: TextButton(
                              child: Text(pfp.button2,style: TextStyle(color: Colors.grey, fontSize: 16)),
                              onPressed: (){
                                Navigator.pop(context);
                                updateData();
                              },
                            )
                        );
                      } else {
                        return Align(
                            alignment: Alignment(0.8, 0.5),
                            child: TextButton(
                              child: Text('Save',style: TextStyle(color: Colors.grey, fontSize: 16)),
                              onPressed: () async {
                                Navigator.pop(context);

                              },
                            )
                        );
                      }
                    }),
               //saveButton(),
                Divider(thickness: 0.2, color: Colors.black,),
                //FirstNameBox
                Row(
                  children: [
                    StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text(pfp.text1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text('ErrorText1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          }
                        }),
                    StreamBuilder<Object>(
                        stream: _ucontroller.stream, // Known Bug is when use _contoller.stream it still works lol?!?!?
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child:
                                TextFormField(
                                  initialValue: usr.firstname,
                                  //TODO implement validator
                                  onChanged: (text) async {
                                    usr.firstname = text;
                                    print(usr.firstname);
                                  },
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    )
                                  ),
                                ),
                            );
                          } else {
                            return firstNameBox(user);
                          }
                        }),
                  ],
                ),
                Divider(thickness: 0.2, color: Colors.black,),
               //LastNameBox
                Row(
                  children: [
                    StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text(pfp.text2, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text('ErrorText2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          }
                        }),
                    StreamBuilder<Object>(
                        stream: _ucontroller.stream, // Known Bug is when use _contoller.stream it still works lol?!?!?
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child:
                              TextFormField(
                                initialValue: usr.lastname,
                                //TODO implement validator
                                onChanged: (text) async {
                                  usr.lastname = text;
                                  print(usr.lastname);
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    )
                                ),
                              ),
                            );
                          } else {
                            return lastNameBox(user);
                          }
                        }),
                  ],
                ),
                Divider(thickness: 0.2, color: Colors.black,),
                //telephoneBox
                Row(
                  children: [
                    StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text(pfp.text3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text('ErrorText3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          }
                        }),
                    StreamBuilder<Object>(
                        stream: _ucontroller.stream, // Known Bug is when use _contoller.stream it still works lol?!?!?
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child:
                              TextFormField(
                                initialValue: usr.telephone,
                                //TODO implement validator
                                onChanged: (text) async {
                                  usr.telephone = text;
                                  print(usr.telephone);
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    )
                                ),
                              ),
                            );
                          } else {
                            return telephoneBox(user);
                          }
                        }),
                  ],
                ),
                Divider(thickness: 0.2, color: Colors.black,),
               //roleBox
                Row(
                  children: [
                    StreamBuilder<Object>(
                        stream: _controller.stream,
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text(pfp.text4, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child: Text('ErrorText4', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                          }
                        }),
                    StreamBuilder<Object>(
                        stream: _ucontroller.stream, // Known Bug is when use _contoller.stream it still works lol?!?!?
                        builder: (context, snapshot){
                          if (snapshot != null &&
                              snapshot.hasData &&
                              snapshot.data == "success") {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 15,
                              child:
                              TextFormField(
                                initialValue: usr.role,
                                //TODO implement validator
                                onChanged: (text) async {
                                  usr.role = text;
                                  print(usr.role);
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    )
                                ),
                              ),
                            );
                          } else {
                            return roleBox(user);
                          }
                        }),
                  ],
                ),
            ],
          )
        ),
      ),
    );
  }

  void updateData() {
    try {
      databaseReference.collection('users_testpull')
          .doc('testId')
          .update({
            'email': "${usr.email}",
            'firstname': "${usr.firstname}",
            'lastname': "${usr.lastname}",
            'role': "${usr.role}",
            'telephone': "${usr.telephone}",
          });
    } catch (e) {
      print(e.toString());
    }
  }

//----------------------------------------------------------------------------------------------------------------------------------------------//
  Widget buildName(User user) => Column(
    children: [
      Text(user.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
    ],
  );

  Widget saveButton() => Align(
      alignment: Alignment(0.8, 0.5),
      child: TextButton(
        child: Text('Save',style: TextStyle(color: Colors.grey, fontSize: 16)),
        onPressed: (){
          //TODO Implement validation and Firestore update
          print('Take me to the profile page');
        },
      )
  );

  Widget firstNameBox(User user) => Container(
      child: Row(
          children:[
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 15,
              child: TextFieldWidget(
                text: user.firstname,
                onChanged: (firstname) {

                },
              ),
            )
          ]
      )
  );

  Widget lastNameBox(User user) => Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: TextFieldWidget(
          text: user.lastname,
          onChanged: (lastname) {

          },
        ),
      )
    ],
  );

  Widget telephoneBox(User user) => Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: TextFieldWidget(
          text: user.telephone,
          onChanged: (telephone) {

          },
        ),
      )
    ],
  );

  Widget roleBox(User user) => Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: TextFieldWidget(
          text: user.role,
          onChanged: (role) {

          },
        ),
      )
    ],
  );


}