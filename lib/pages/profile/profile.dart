import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/utils/loading.dart';
import 'package:device_booking/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/style.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  UserController controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0.0,
          title: Text(
            'Profile',
            style: appBarTextStyle,
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Get.offNamed('/editprofile');
                },
                child: Text('Edit', style: appBarTextStyle))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Container(
              child: Column(
                children: [
                  ClipOval(
                    child: (controller.streamUser?.photoURL != null)
                        ? Obx(() => Image.network(
                              controller.streamUser?.photoURL ?? '',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height / 5,
                              // width: MediaQuery.of(context).size.width / 5,
                            ))
                        : Image.asset(
                            'assets/images/profile_placeholder.png',
                            fit: BoxFit.cover, //TODO fit this image to the box
                          ),
                  ),
                ],
              ),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: Obx(() => Text('${controller.streamUser?.email ?? ''}',
                    style: b1TextStyle)),
              ),
            ),
            Align(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: Obx(
                    () => Text('UID: ${controller.streamUser?.uid ?? ''}',
                        style: b2TextStyle),
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
                  await AuthService().signOut();
                  Get.offAllNamed('/');
                },
                child: Text('Log out',
                    style: GoogleFonts.kanit(
                        fontSize: mediumTextSize, color: Colors.redAccent))),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  // UserController controller;

  // ProfileInfo(this.controller);
  UserController userController = Get.put(UserController());
  // ProfileController controller = Get.put(ProfileController());

  // List<List<String>> _profileList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: userController,
        builder: (controller) => Table(
              border: TableBorder(
                  horizontalInside: BorderSide(width: 1, color: Colors.grey)),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'First name',
                      style: b1TextStyle,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => Text(
                          '${controller.streamUser?.firstname ?? ''}',
                          style: b1TextStyle,
                        ),
                      )),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Last name',
                      style: b1TextStyle,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => Text(
                          '${controller.streamUser?.lastname ?? ''}',
                          style: b1TextStyle,
                        ),
                      )),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Tel.',
                      style: b1TextStyle,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => Text(
                          '${controller.streamUser?.phoneNumber ?? ''}',
                          style: b1TextStyle,
                        ),
                      )),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Role',
                      style: b1TextStyle,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => Text(
                          '${controller.streamUser?.role ?? ''}',
                          style: b1TextStyle,
                        ),
                      )),
                ]),
              ],
            ));
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
    //                     style: b1TextStyle,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(10.0),
    //                   child: Text(
    //                     '${item[1] ?? ''}',
    //                     style: b1TextStyle,
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
