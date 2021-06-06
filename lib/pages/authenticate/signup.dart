import 'package:device_booking/controller/auth_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/style.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/services/database.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String valueChoose;
  // UserController controller = Get.put(UserController());
  UserData _user;
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // _user = controller.user;
    _user = AuthService().userDataFromFirebaseUser(controller.firebaseUser);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () async {
                await AuthService().signOut();
                Get.back();
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
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue, padding: EdgeInsets.all(4)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    print('Submit Form Successful');
                    await DBService().registerNewUser(_user);
                    Get.back();
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
                    height: MediaQuery.of(context).size.height / 5,
                    child: ClipOval(
                      child: (_user.photoURL != null)
                          ? Obx(() => Image.network(
                                controller.firebaseUser.photoURL ?? '',
                                fit: BoxFit.cover,
                              ))
                          : Image.asset(
                              'assets/images/profile_placeholder.png',
                              fit:
                                  BoxFit.cover, //TODO fit this image to the box
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
                    child: Text('${_user.email ?? ''}', style: b1TextStyle),
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
                                  _user.firstname = text;
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
                                  _user.lastname = text;
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
                                initialValue: _user.phoneNumber,
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
                                  _user.phoneNumber = text;
                                  print(_user.phoneNumber);
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
                                valueChoose = value;
                                _user.role = value;
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

  // String validateName(String value) {
  //   if (value.length < 3)
  //     return 'Must be more than 2 charater';
  //   else
  //     return null;
  // }

  // String validatePhoneNumber(String value) {
  //   if (value.length != 10)
  //     return 'Must have 10 digits';
  //   else if (value.substring(0, 1) != '0')
  //     return 'Phone number must start with 0';
  //   else
  //     return null;
  //   return null;
  // }
  // // //customized textFormField function here!
  // Widget textFormField(String collectVar, String labelText, String hintText,
  //         String errorText) =>
  //     TextFormField(
  //         initialValue: collectVar,
  //         validator: (value) {
  //           return (value == null || value.isEmpty) ? errorText : null;
  //         },
  //         onChanged: (text) {
  //           collectVar = text;
  //         },
  //         decoration: InputDecoration(
  //             labelText: labelText,
  //             labelStyle: h3TextStyle,
  //             hintText: hintText,
  //             border: UnderlineInputBorder(
  //                 borderRadius: BorderRadius.circular(4.0))));

  // //add additional TextFormField here!
  // UserTextFormFields userForm;
  // setUserForm() {
  //   userForm = UserTextFormFields([
  //     UserTextFormField(user.firstname, 'First name', 'Enter your first name',
  //         'Please enter your first name'),
  //     UserTextFormField(user.lastname, 'Last name', 'Enter your last name',
  //         'Please enter your first name'),
  //     UserTextFormField(user.phomeNumber, 'Phone number',
  //         'Enter your first name', 'Please enter your phone number'),
  //     // UserTextFormField(user.role, 'Role', 'Medical student / Intern / Resident',
  //     //     'Please enter your first name'),
  //   ]);
  // }

  // //add to column
  // List<Widget> textFormFields(UserTextFormFields userForm) {
  //   return userForm.formFields
  //       .map((formField) => textFormField(formField.collectVar,
  //           formField.labelText, formField.hintText, formField.errorText))
  //       .toList();
  // }

}
