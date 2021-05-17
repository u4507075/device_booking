// import 'package:device_booking/user/user_pref.dart';
// import 'package:device_booking/widget/appbar_widget.dart';
// import 'package:device_booking/widget/profile_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:device_booking/user/user.dart';

// class ProfilePage extends StatefulWidget{
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     final user = UserPreferences.myUser;

//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ProfileWidget(imagePath: user.imagePath,),
//           const SizedBox(height: 20),
//           buildName(user),
//           editButton(),
//           Divider(color: Colors.black,),
//           firstNameBox(user),
//           Divider(color: Colors.black,),
//           lastNameBox(user),
//           Divider(color: Colors.black,),
//           telephoneBox(user),
//           Divider(color: Colors.black,),
//           roleBox(user),
//         ],
//       ),
//     );
//   }

//   Widget buildName(User user) => Column(
//     children: [
//       Text(user.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//     ],
//   );

//   Widget editButton() => Align(
//       alignment: Alignment(0.8, 0.5),
//       child: TextButton(
//         child: Text('Edit',style: TextStyle(color: Colors.grey, fontSize: 20)),
//         onPressed: (){
//           print('Take me to the edit page');
//         },
//       )
//   );

//   Widget firstNameBox(User user) => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Text('First Name',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
//       Text(user.firstname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
//     ],
//   );

//   Widget lastNameBox(User user) => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Text('Last Name',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//       Text(user.lastname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//     ],
//   );

//   Widget telephoneBox(User user) => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Text('Telephone',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//       Text(user.telephone, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//     ],
//   );

//   Widget roleBox(User user) => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Text('Role',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//       Text(user.role, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//     ],
//   );

// }
