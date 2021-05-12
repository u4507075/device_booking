import 'package:device_booking/user/user_pref.dart';
import 'package:device_booking/widget/appbar_widget.dart';
import 'package:device_booking/widget/profileedit_widget.dart';
import 'package:device_booking/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_booking/user/user.dart';

class ProfilePageEdit extends StatefulWidget{
  @override
  _ProfilePageEditState createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: (
            Column(
              children: [
               ProfileEditWidget(imagePath: user.imagePath,),
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
          )
        ),
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
          print('Take me to the edit page');
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
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 15,
              child: TextFieldWidget(
                text: user.firstname,
                onChanged: (firstname) {
                },
              ),
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
      Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: TextFieldWidget(
          text: user.lastname,
          onChanged: (lastname) {

          },
        ),
      )
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
      Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: TextFieldWidget(
          text: user.telephone,
          onChanged: (telephone) {},
        ),
      )
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
      Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: TextFieldWidget(
          text: user.role,
          onChanged: (role) {},
        ),
      )
    ],
  );


}