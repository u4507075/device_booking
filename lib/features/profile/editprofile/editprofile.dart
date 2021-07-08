import 'package:device_booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  UserController controller = Get.put(UserController());
  UserData? _user = Get.find<UserController>().streamUser;
  String? valueChoose = Get.find<UserController>().streamUser?.role;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () async {
                Get.back();
              },
            ),
            elevation: 0.0,
            title: Text(
              'Edit Profile',
              style: appBarTextStyle,
            ),
            centerTitle: true,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue, padding: EdgeInsets.all(4)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('Submit Form Successful');
                    await controller.updateUser(user: _user);
                    Get.offNamed('/profile');
                  } else {
                    //TODO add snack bar
                    print('Submit Form failed');
                    // print('${controller.user.email}');
                  }
                },
                child: Text(
                  'Save',
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
                      child: (_user?.photoURL != '')
                          ? Obx(() => Image.network(
                                controller.streamUser?.photoURL ?? '',
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
                    child: Text('${controller.streamUser?.email ?? ''}',
                        style: b1TextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                    child: Text('UID: ${controller.streamUser?.uid ?? ''}',
                        style: b2TextStyle),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //Enter firstname
                            TextFormField(
                                initialValue: controller.streamUser?.firstname,
                                validator: (value) {
                                  return (value == null ||
                                          value.isEmpty ||
                                          value.length < 3)
                                      ? 'Must contain at least 2 characters'
                                      : null;
                                },
                                onChanged: (text) async {
                                  _user?.firstname = text;
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
                                initialValue: controller.streamUser?.lastname,
                                validator: (value) {
                                  return (value == null ||
                                          value.isEmpty ||
                                          value.length < 3)
                                      ? 'Must contain at least 2 characters'
                                      : null;
                                },
                                onChanged: (text) async {
                                  _user?.lastname = text;
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
                                initialValue: '0' +
                                    (_user?.phoneNumber ?? '').substring(
                                        (_user?.phoneNumber ?? '').length - 9),
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
                                  _user?.phoneNumber = text;
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
