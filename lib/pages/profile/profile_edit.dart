import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_booking/models/pfpages.dart';
import 'package:device_booking/models/user_page.dart';
import 'package:device_booking/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_booking/style.dart';
import 'package:device_booking/widget/profile_widget.dart';
import 'package:device_booking/models/user.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

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
                            Navigator.pushNamed(context, '/loading');
                            updateData().then((data) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(pfp.button2, textAlign: TextAlign.center, style: appBarTextStyle),
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
                            /*DropdownButtonFormField(
                              hint: Text('Select your role'),
                              value: valueChoose,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: mediumTextSize,
                              elevation: 16,
                              style: b1TextStyle,
                              onChanged: (value) async {
                                setState(() {
                                  valueChoose = value;
                                  usr.role = value;
                                });
                              },
                              items: <String>[
                                'Medical Student 4',
                                'Medical Student 5',
                                'Extern',
                                'Intern',
                                'Resident',
                                'Staff'
                              ],
                            )*/

                                  // TextFormField(
                                  //   initialValue: usr.role,
                                  //   //TODO implement validator
                                  //   onChanged: (text) async {
                                  //     usr.role = text;
                                  //     print(usr.role);
                                  //   },
                                  // ),
                                  DropdownButtonFormField(
                                    validator: (value) => value == null
                                        ? 'Please select your role'
                                        : null,
                                    isExpanded: true,
                                    hint: Text('Select you role'),
                                    value: valueChoose,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: mediumTextSize,
                                    elevation: 16,
                                    style: b1TextStyle,
                                    onChanged: (value) async {
                                      setState(() {
                                        valueChoose = value;
                                        usr.role = value;
                                      });
                                    },
                                    items: <String>[
                                      'Medical Student 4',
                                      'Medical Student 5',
                                      'Extern',
                                      'Intern',
                                      'Resident',
                                      'Staff'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
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

  Future<void> updateData() async{
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

}