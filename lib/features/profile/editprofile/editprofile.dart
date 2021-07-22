import 'package:device_booking/core/core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:styled_widget/styled_widget.dart';

class EditProfile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var imageController = Get.put(ImageController());
  UserController controller = Get.put(UserController());
  UserData? _user = Get.find<UserController>().streamUser;
  String? valueChoose = Get.find<UserController>().streamUser?.role;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
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
              style: Get.theme.accentTextTheme.headline6,
            ),
            centerTitle: true,
            actions: [
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(4)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //?Open loading dialog
                    Get.dialog(
                      LoadingDialog(),
                      barrierDismissible: false,
                    );

                    //?update user infomation to local memory
                    controller.setUser(_user!);

                    //?upload a new profile image
                    imageController.file != null
                        ? controller.photoURL =
                            await imageController.uploadProfileImage()
                        : null;

                    //?update user infomation to Firestore
                    await controller.updateUser();
                    //?Close loading dialog
                    Get.back();
                    //?Close edit profile page
                    Get.back();

                    print('Submit Form Successful');
                    Get.snackbar('MedTrack', 'User Profile Updated',
                        backgroundColor:
                            Get.theme.canvasColor.withOpacity(0.6));
                  } else {
                    print('Submit Form failed');
                  }
                },
                child: Text(
                  'Save',
                  style: Get.theme.accentTextTheme.headline6,
                ),
              )
            ],
          ),
          body: GestureDetector(
            onTap: () =>
                (!currentFocus.hasPrimaryFocus) ? currentFocus.unfocus() : null,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _DisplayProfile(),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
                    //   child: Text('${controller.streamUser?.email ?? ''}',
                    //       style: b1TextStyle),
                    // ),
                    Text('UID: ${controller.streamUser?.uid ?? ''}',
                            style: Get.textTheme.bodyText1)
                        .paddingSymmetric(vertical: 20),

                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //Enter firstname
                              TextFormField(
                                  initialValue:
                                      controller.streamUser?.firstname,
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
                                      labelStyle: Get.theme.textTheme.headline6,
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
                                      labelStyle: Get.theme.textTheme.headline6,
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
                                    _user?.phoneNumber = text;
                                    print(_user?.phoneNumber);
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Phone number",
                                      labelStyle: Get.theme.textTheme.headline6,
                                      hintText: 'Enter your phone number',
                                      border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0)))),

                              SizedBox(height: 20),
                              DropdownButtonFormField(
                                onTap: () => (!currentFocus.hasPrimaryFocus)
                                    ? currentFocus.unfocus()
                                    : null,
                                validator: (value) => value == null
                                    ? 'Please select your role'
                                    : null,
                                isExpanded: true,
                                hint: Text('Select you role'),
                                value: valueChoose,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: Get.textTheme.bodyText1!.fontSize!,
                                elevation: 16,
                                style: Get.theme.textTheme.bodyText1,
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
                                    child: Text(value).textStyle(
                                        Theme.of(context).textTheme.bodyText1!),
                                  );
                                }).toList(),
                              )
                            ])),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class _DisplayProfile extends GetView<UserController> {
  var imageController = Get.put(ImageController());
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    print(pressed);
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return [
          ((imageController.file != null)
                  ? Obx(() => Image.file(imageController.file!))
                  : (controller.user?.photoURL != '')
                      ? Obx(() => Image.network(
                            controller.streamUser?.photoURL ?? '',
                            fit: BoxFit.cover,
                          ))
                      : Image.asset(
                          'assets/images/profile_placeholder.png',
                          fit: BoxFit.cover,
                        ))
              .fittedBox(fit: BoxFit.cover)
              .constrained(height: Get.height / 5, width: Get.height / 5)
              .center(), //TODO fit this image to the box

          Container().decorated(
              color: Colors.black.withOpacity(pressed ? 0.6 : 0.3),
              animate: true),
          Styled.text('Change photo',
                  animate: true,
                  style: Get.textTheme.bodyText2!
                      .copyWith(color: Get.theme.canvasColor))
              .center()
        ]
            .toStack()
            .constrained(height: Get.height / 5, width: Get.height / 5)
            .clipOval()
            .gestures(
              onTapChange: (tapState) => setState(() => pressed = tapState),
              onTap: () => _openBottomSheet(),
            )
            .scale(all: pressed ? 0.9 : 1, animate: true)
            .animate(Duration(milliseconds: 400), Curves.easeInOutCirc);
      },
    );
  }

  Future<dynamic> _openBottomSheet() {
    final _picker = ImagePicker();
    return Get.bottomSheet(
      Container(
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'Upload an image',
                  style: Get.textTheme.bodyText1,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Select from a gallery',
                    style: Get.textTheme.bodyText2,
                  ),
                  onTap: () async {
                    //Close bottomsheet
                    Get.back();

                    //Open loading
                    Get.dialog(LoadingDialog(), barrierDismissible: false);

                    imageController.image = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 100,
                        maxHeight: 300,
                        maxWidth: 300);
                    //Close loading dialog
                    Get.back();

                    print(imageController.file?.absolute);
                  },
                ),
                ListTile(
                  title: Text(
                    'Take a new photo',
                    style: Get.textTheme.bodyText2,
                  ),
                  onTap: () async {
                    //Close bottomsheet
                    Get.back();

                    //Open loading
                    Get.dialog(LoadingDialog(), barrierDismissible: false);

                    imageController.image = await _picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100,
                        maxHeight: 300,
                        maxWidth: 300);
                    //Close loading dialog
                    Get.back();

                    print(imageController.file?.absolute);
                  },
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
