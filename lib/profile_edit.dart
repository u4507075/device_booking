import 'dart:async';
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
               saveButton(),
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
                            return Text(usr.firstname, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16));
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
                            return Text(usr.lastname, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16));
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
                            return Text(usr.telephone, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16));
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
                            return Text(usr.role, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16));
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