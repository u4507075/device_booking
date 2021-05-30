import 'package:device_booking/controller/profile_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/widget/profile_widget.dart';
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
                  Get.toNamed('/editprofile');
                },
                child: Text('Edit', style: appBarTextStyle))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: ClipOval(
                    child: (controller.user?.photoURL != null)
                        ? Image.network(
                            controller.user?.photoURL,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/profile_placeholder.png',
                            fit: BoxFit.cover, //TODO fit this image to the box
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Obx(() => Text('${controller.user?.email ?? ''}',
                      style: b1TextStyle)),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: Obx(
                      () => Text('UID: ${controller.user?.uid ?? ''}',
                          style: b2TextStyle),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: ProfileInfo(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                    onPressed: () {
                      Get.offAllNamed('/');
                    },
                    child: Text('Log out',
                        style: GoogleFonts.kanit(
                            fontSize: mediumTextSize, color: Colors.redAccent)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  // UserController controller;

  // ProfileInfo(this.controller);

  ProfileController controller = Get.put(ProfileController());

  List<List<String>> _profileList;

  @override
  Widget build(BuildContext context) {
    _profileList = controller.profileList;
    print(_profileList);

    return Table(
      border: TableBorder(
          horizontalInside: BorderSide(width: 1, color: Colors.grey)),
      children: [
        for (var item in _profileList)
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${item[0] ?? ''}',
                style: b1TextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${item[1] ?? ''}',
                style: b1TextStyle,
              ),
            ),
          ]),
      ],
    );
  }
}
