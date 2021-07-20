import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_booking/core/core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';

class Profile extends GetView<UserController> {
  // final UserController controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0.0,
          title: Text(
            'Profile',
            style: Get.theme.accentTextTheme.headline6,
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Get.toNamed('/editprofile');
                },
                child: Text('Edit', style: Get.theme.accentTextTheme.headline6))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Container(
              child: Column(
                children: [
                  ClipOval(
                    child: GetBuilder<UserController>(
                        init: controller,
                        builder: (controller) => ((controller.user?.photoURL !=
                                        '' &&
                                    controller.user?.photoURL != null)
                                ? FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/images/profile_placeholder.png'),
                                    image: NetworkImage(
                                      controller.user!.photoURL!,
                                    ),
                                    fadeOutDuration:
                                        Duration(milliseconds: 300),
                                    fadeOutCurve: Curves.easeOutBack,
                                    fadeInDuration: Duration(milliseconds: 300),
                                    fit: BoxFit.cover)
                                : Image.asset(
                                    'assets/images/profile_placeholder.png',
                                    fit: BoxFit.cover))
                            .constrained(
                                height: Get.height / 5, width: Get.height / 5)),
                  ),
                ],
              ),
            ),
            // Align(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            //     child: Obx(() => Text('${controller.streamUser?.email ?? ''}',
            //         style: Get.textTheme.headline6)),
            //   ),
            // ),
            Align(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: Obx(
                    () => Text('UID: ${controller.streamUser?.uid ?? ' '}',
                        style: Get.theme.textTheme.bodyText1),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: ProfileInfo(),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
                onPressed: () async {
                  Get.defaultDialog(
                    title: 'Confirmation',
                    textConfirm: 'Log out',
                    confirmTextColor: Colors.white,
                    cancelTextColor: Colors.black,
                    buttonColor: Colors.red[800],
                    middleText: 'Do you want to log out?',
                    textCancel: 'Cancel',
                    onConfirm: () async {
                      await AuthController().signOut();
                      Get.delete<UserController>();
                      Get.offAllNamed('/');
                    },
                    onCancel: () {
                      print('Cancel');
                    },
                  );
                },
                child: Text('Log out',
                    style: Get.theme.accentTextTheme.headline6!
                        .copyWith(color: Get.theme.errorColor))),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  // UserController controller;

  // ProfileInfo(this.controller);
  final UserController userController = Get.find<UserController>();
  // ProfileController controller = Get.put(ProfileController());

  // List<List<String>> _profileList;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(
          horizontalInside: BorderSide(width: 1, color: Colors.grey)),
      children: [
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'First name',
              style: Get.textTheme.headline6,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => Text(
                  '${userController.streamUser?.firstname ?? ''}',
                  style: Get.textTheme.headline6,
                ),
              )),
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Last name',
              style: Get.textTheme.headline6,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => Text(
                  '${userController.streamUser?.lastname ?? ''}',
                  style: Get.textTheme.headline6,
                ),
              )),
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Tel.',
              style: Get.textTheme.headline6,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() => Text(
                      formatPhoneNumber(
                          userController.streamUser?.phoneNumber ?? ''),
                      style: Get.textTheme.headline6)
                  // ( != '')
                  //     ? Text(
                  //         '${'0' + (controller.streamUser?.phoneNumber ?? '').substring((controller.streamUser?.phoneNumber ?? ' ').length - 9)}',
                  //         style: Get.textTheme.headline6,
                  //       )
                  //     : Text(''),
                  )),
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Role',
              style: Get.textTheme.headline6,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => Text(
                  '${userController.streamUser?.role ?? ''}',
                  style: Get.textTheme.headline6,
                ),
              )),
        ]),
      ],
    );
    // _profileList = controller.list;
    // print(_profileList);
    // return GetBuilder<UserController>(
    //     init: userController,
    //     builder: (controller) {
    //       if (controller != null && controller.user != null) {
    //         _profileList = [
    //           ['First name', controller.user?.firstname ?? ''],
    //           ['Last name', controller.user?.lastname ?? ''],
    //           ['Tel.', controller.user?.phoneNumber ?? ''],
    //           ['Role', controller.user?.role ?? '']
    //         ];

    //         return Table(
    //           border: TableBorder(
    //               horizontalInside: BorderSide(width: 1, color: Colors.grey)),
    //           children: [
    //             for (var item in _profileList)
    //               TableRow(children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(10.0),
    //                   child: Text(
    //                     '${item[0] ?? ''}',
    //                     style: Get.textTheme.headline6,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(10.0),
    //                   child: Text(
    //                     '${item[1] ?? ''}',
    //                     style: Get.textTheme.headline6,
    //                   ),
    //                 ),
    //               ]),
    //           ],
    //         );
    //       } else {
    //         return Loading();
    //       }
    //     });
  }
}
