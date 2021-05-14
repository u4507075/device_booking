import 'package:device_booking/dataservice.dart';
import 'package:device_booking/firebasedb.dart';
import 'package:device_booking/profile_edit.dart';
import 'package:device_booking/widget/appbar_widget.dart';
import 'package:device_booking/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:device_booking/user/user_list.dart';
import 'package:device_booking/user/user_list.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class ProfilePageNew extends StatefulWidget{
  @override
  _ProfilePageNewState createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends State<ProfilePageNew> {

  String imagePath = 'https://pbs.twimg.com/profile_images/378800000857919980/lHqPIZza_400x400.png';
  String email = 'test@gmail.com';
  String firstname = 'fname';
  String lastname = 'lname';
  String telephone = '0123456789';
  String role = 'doctor';

  @override
  Widget build(BuildContext context) {
     return StreamProvider<QuerySnapshot>.value(
       value: DatabaseService().users,
       child: Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: [
            ProfileWidget(imagePath: imagePath,),
            const SizedBox(height: 20),
            buildName(),
            editButton(),
            Divider(thickness: 0.2, color: Colors.black,),
            firstNameBox(),
            Divider(thickness: 0.2, color: Colors.black,),
            lastNameBox(),
            Divider(thickness: 0.2, color: Colors.black,),
            telephoneBox(),
            Divider(thickness: 0.2, color: Colors.black,),
            roleBox(),
          ],
        ),
    ),
     );
  }

  Widget buildName() => Column(
    children: [
      Text(email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
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

  Widget firstNameBox() => Container(
      child: Row(
          children:[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 15,
              child: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Text(firstname, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)
            )
          ]
      )
  );

  Widget lastNameBox() => Row(
    children: [
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: Text('Last Name',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Text(lastname, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))
    ],
  );

  Widget telephoneBox() => Row(
    children: [
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: Text('Telephone',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Text(telephone, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))
    ],
  );

  Widget roleBox() => Row(
    children: [
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: Text('Role',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Text(role, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16))
    ],
  );

}

/*
class Userr {
  Userr({this.imagePath, this.email, this.firstname, this.lastname, this.telephone, this.role});

  Userr.fromJson(Map<String, Object> json)
      : this(
    imagePath: json['imagePath'] as String,
    email: json['email'] as String,
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    telephone: json['telephone'] as String,
    role: json['role'] as String,
  );

  final String imagePath;
  final String email;
  final String firstname;
  final String lastname;
  final String telephone;
  final String role;

  Map<String, Object> toJson() {
    return {
      'imagePath': imagePath,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'telephone': telephone,
      'role': role,
    };
  }
}
*/
/*
class Userr {
  String imagePath;
  String email;
  String firstname;
  String lastname;
  String telephone;
  String role;

  Userr({
    this.imagePath,
    this.email,
    this.firstname,
    this.lastname,
    this.telephone,
    this.role,
  });
}
 */