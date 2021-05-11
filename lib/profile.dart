import 'package:device_booking/profile_edit.dart';
import 'package:device_booking/user/user_pref.dart';
import 'package:device_booking/widget/appbar_widget.dart';
import 'package:device_booking/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_booking/user/user.dart';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          ProfileWidget(imagePath: user.imagePath,),
          const SizedBox(height: 20),
          buildName(user),
          editButton(),
          Divider(thickness: 0.2, color: Colors.black,),
          firstNameBox(user),
          Divider(thickness: 0.2, color: Colors.black,),
          lastNameBox(user),
          Divider(thickness: 0.2, color: Colors.black,),
          telephoneBox(user),
          Divider(thickness: 0.2, color: Colors.black,),
          roleBox(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(user.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
    ],
  );

  Widget editButton() => Align(
      alignment: Alignment(0.8, 0.5),
      child: TextButton(
        child: Text('Edit',style: TextStyle(color: Colors.grey, fontSize: 16)),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProfilePageEdit()),
          );
        },
      )
  );

  Widget firstNameBox(User user) => Container(
    child: Row(
      children:[
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 15,
            child: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
        ),
        Text(user.firstname, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)
        )
      ]
    )
  );

  Widget lastNameBox(User user) => Row(
    children: [
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: Text('Last Name',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Text(user.lastname, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))
    ],
  );

  Widget telephoneBox(User user) => Row(
    children: [
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: Text('Telephone',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Text(user.telephone, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))
    ],
  );

  Widget roleBox(User user) => Row(
    children: [
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: Text('Role',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Text(user.role, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))
    ],
  );


}
