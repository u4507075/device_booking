import 'package:device_booking/models/user/user.dart';
import 'package:device_booking/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/models/user/user.dart';
import 'package:device_booking/style.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        elevation: 0.0,
        title: Text(
          'Profile',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileWidget(
            imagePath: user.photoURL,
          ),
          const SizedBox(height: 20),
          buildName(user),
          editButton(),
          Divider(
            color: Colors.black,
          ),
          firstNameBox(user),
          Divider(
            color: Colors.black,
          ),
          lastNameBox(user),
          Divider(
            color: Colors.black,
          ),
          telephoneBox(user),
          Divider(
            color: Colors.black,
          ),
          roleBox(user),
        ],
      ),
    );
  }

  Widget buildName(UserData user) => Column(
        children: [
          Text(user.email,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
        ],
      );

  Widget editButton() => Align(
      alignment: Alignment(0.8, 0.5),
      child: TextButton(
        child: Text('Edit', style: TextStyle(color: Colors.grey, fontSize: 20)),
        onPressed: () {
          print('Take me to the edit page');
        },
      ));

  Widget firstNameBox(UserData user) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'First Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            user.firstname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      );

  Widget lastNameBox(UserData user) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Last Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Text(user.lastname,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
        ],
      );

  Widget telephoneBox(UserData user) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Telephone',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          // Text(user.phoneNumber,
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
        ],
      );

  Widget roleBox(UserData user) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Role',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Text(user.role,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
        ],
      );
}
