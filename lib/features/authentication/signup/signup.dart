import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? valueChoose;
  var _user = Get.find<AuthController>().user;

  // UserData? _initialUser = UserData();

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    print(_user?.phoneNumber);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () async {
                await AuthController().signOut();
                Get.offAllNamed('/');
              },
            ),
            elevation: 0.0,
            title: Text(
              'Sign Up',
              style: appBarTextStyle,
            ),
            centerTitle: true,
            actions: [
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(4)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('Submit Form Successful');
                    print(_user?.firstname);
                    await userController.registerNewUser(user: _user!);

                    userController.setUser(_user!);
                    print('${userController.user?.phoneNumber}');
                    // Get.toNamed('/');
                    Get.offAllNamed('/');
                  } else {
                    //TODO add snack bar
                    print('Submit Form failed');
                    // print('${controller.user.email}');
                  }
                },
                child: Text(
                  'Next',
                  style: appBarTextStyle,
                ),
              )
            ],
          ),
          body: ListView(children: [
            Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 5,
                      backgroundImage: NetworkImage(
                          // _user.firebaseUser!.photoURL ??
                          'https://device-tracking-system.obs.ap-southeast-2.myhuaweicloud.com/img/profile_placeholder.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
                    child: Text('${_user?.email ?? ''}', style: b1TextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                    child: Text('UID: ${_user?.uid ?? ''}', style: b2TextStyle),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //Enter firstname
                            TextFormField(
                                initialValue: _user?.firstname,
                                validator: (value) {
                                  return (value == null ||
                                          value.isEmpty ||
                                          value.length < 3)
                                      ? 'Must contain at least 2 characters'
                                      : null;
                                },
                                onChanged: (text) async {
                                  _user?.firstname = text;
                                  print(_user?.firstname);
                                },
                                decoration: InputDecoration(
                                    labelText: "First name",
                                    labelStyle: h3TextStyle,
                                    hintText: 'Enter your first name',
                                    border: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)))),
                            //Enter lastname
                            TextFormField(
                                initialValue: _user?.lastname,
                                validator: (value) {
                                  return (value == null ||
                                          value.isEmpty ||
                                          value.length < 3)
                                      ? 'Must contain at least 2 characters'
                                      : null;
                                },
                                onChanged: (text) async {
                                  _user?.setlastName = text;
                                },
                                decoration: InputDecoration(
                                    labelText: "Last name",
                                    labelStyle: h3TextStyle,
                                    hintText: 'Enter your last name',
                                    border: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)))),

                            //Enter phonenumber
                            TextFormField(
                                enabled: false,
                                initialValue:
                                    formatPhoneNumber(_user!.phoneNumber),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  return (value == null ||
                                          value.isEmpty ||
                                          value.length != 10 ||
                                          value.substring(0, 1) != '0')
                                      ? 'Must contain 10 digits and start with 0'
                                      : null;
                                },
                                onChanged: (text) async {
                                  _user?.setphoneNumber = text;
                                  print(_user?.phoneNumber);
                                },
                                decoration: InputDecoration(
                                    labelText: "Phone number",
                                    labelStyle: h3TextStyle,
                                    hintText: 'Enter your phone number',
                                    border: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)))),

                            SizedBox(height: 20),
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
                                valueChoose = value as String;
                                _user?.role = value;
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
                            )
                          ])),
                ],
              ),
            ),
          ])),
    );
  }
}
