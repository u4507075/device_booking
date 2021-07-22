import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:styled_widget/styled_widget.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? valueChoose;
  var _user = Get.find<AuthController>().user;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    var imageController = Get.put(ImageController());
    print(_user?.phoneNumber);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () async {
                await AuthController().signOut();
                Get.offAllNamed('/');
                Get.delete<UserController>();
              },
            ),
            elevation: 0.0,
            title: Text(
              'Sign Up',
              style: Get.theme.accentTextTheme.headline6,
            ),
            centerTitle: true,
            actions: [
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(4)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('Submit Form Successful');
                    //?Open loading dialog
                    Get.dialog(
                      LoadingDialog(),
                      barrierDismissible: false,
                    );
                    //?upload a new profile image
                    imageController.file != null
                        ? userController.photoURL =
                            await imageController.uploadProfileImage()
                        : null;

                    await userController.registerNewUser(user: _user!);
                    //?Close loading dialog
                    Get.back();

                    userController.setUser(_user!);

                    Get.offAllNamed('/');
                  } else {
                    //TODO add snack bar
                    print('Submit Form failed');
                  }
                },
                child: Text(
                  'Next',
                  style: Get.theme.accentTextTheme.headline6,
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
                  _DisplayProfile(),
                  // SizedBox(
                  //   child: CircleAvatar(
                  //     radius: MediaQuery.of(context).size.width / 5,
                  //     backgroundImage: NetworkImage(
                  //         // _user.firebaseUser!.photoURL ??
                  //         'https://device-tracking-system.obs.ap-southeast-2.myhuaweicloud.com/img/profile_placeholder.png'),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
                    child: Text('${_user?.email ?? ''}',
                        style: Get.textTheme.bodyText1),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                    child: Text('UID: ${_user?.uid ?? ''}',
                        style: Get.textTheme.bodyText1),
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
                                    labelStyle: Get.textTheme.bodyText1,
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
                                    labelStyle: Get.textTheme.bodyText1,
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
                                    labelStyle: Get.textTheme.bodyText1,
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
                              iconSize: Get.textTheme.bodyText1!.fontSize!,
                              elevation: 16,
                              style: Get.textTheme.bodyText1,
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

class _DisplayProfile extends GetView<UserController> {
  var imageController = Get.put(ImageController());
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    print(pressed);
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return [
          Obx(() => ((imageController.file != null))
                  ? Obx(() => Image.file(imageController.file!))
                  // : (controller.user?.photoURL != '' &&
                  //         controller.user?.photoURL != null)
                  //     ? Obx(() => Image.network(
                  //           controller.streamUser?.photoURL ?? '',
                  //           fit: BoxFit.cover,
                  //         ))
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
                    //? Close loading dialog

                    Get.back();

                    print(
                        'Found a file: ${imageController.file?.absolute.toString()}');
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
