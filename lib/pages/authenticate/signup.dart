import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/style.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map userMap = ModalRoute.of(context).settings.arguments;
    final UserData user = userMap['user'];
    print(user.photoURL);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            elevation: 0.0,
            title: Text(
              'Sign Up',
              style: appBarTextStyle,
            ),
            centerTitle: true,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue, padding: EdgeInsets.all(4)),
                onPressed: () {},
                child: Text(
                  'Next',
                  style: appBarTextStyle,
                ),
              )
            ],
            // backgroundColor: Colors.transparent,
          ),
          body: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 20.0,
                // ),
                ClipOval(
                  child: Image.network(user.photoURL),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                  child: Text(user.email, style: b1TextStyle),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Table(
                      border: TableBorder(horizontalInside: BorderSide()),
                      children: [
                        TableRow(
                          children: [
                            Text('User', style: b1TextStyle),
                            Text('Intern Patipan', style: b1TextStyle)
                          ],
                        ),
                        TableRow(
                          children: [
                            Text('Tel', style: b1TextStyle),
                            Text('091-223-2323', style: b1TextStyle)
                          ],
                        ),
                        TableRow(
                          children: [
                            Text('Date', style: b1TextStyle),
                            Text('12 May 2021', style: b1TextStyle)
                          ],
                        ),
                        TableRow(
                          children: [
                            Text('Role', style: b1TextStyle),
                            Text('12.00 - 12.15', style: b1TextStyle)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// TableRow tableRow(String title) {

//   return TableRow(children: [Text(title, style: ,), ]);
// }
// //Signup page
// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   @override
//   Widget build(BuildContext context) {
//     final User user = ModalRoute.of(context).settings.arguments;
//     // final user = User.fetchAll();

//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ClipOval(
//             child: Image.network(user.photoURL),
//           ),
//           const SizedBox(height: 20),
//           buildName(user),
//           editButton(),
//           Divider(
//             color: Colors.black,
//           ),
//           firstNameBox(user),
//           Divider(
//             color: Colors.black,
//           ),
//           lastNameBox(user),
//           Divider(
//             color: Colors.black,
//           ),
//           telephoneBox(user),
//           Divider(
//             color: Colors.black,
//           ),
//           roleBox(user),
//         ],
//       ),
//     );
//   }

//   Widget buildName(User user) => Column(
//         children: [
//           Text(user.email,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//         ],
//       );

//   Widget editButton() => Align(
//       alignment: Alignment(0.8, 0.5),
//       child: TextButton(
//         child: Text('Edit', style: TextStyle(color: Colors.grey, fontSize: 20)),
//         onPressed: () {
//           print('Take me to the edit page');
//         },
//       ));

//   Widget firstNameBox(User user) => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             'First Name',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           ),
//           Text(
//             capitalize(user.displayName.split(' ')[0]),
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           )
//         ],
//       );

//   Widget lastNameBox(User user) => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text('Last Name',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//           Text(capitalize(user.displayName.split(' ')[1]),
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//         ],
//       );

//   Widget telephoneBox(User user) => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text('Telephone',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//           Text(user.phoneNumber,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//         ],
//       );

//   Widget roleBox(User user) => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text('Role',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//           Text('', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
//         ],
//       );
// }

// String capitalize(String string) {
//   if (string.isEmpty) {
//     return string;
//   }

//   return string[0].toUpperCase() + string.substring(1).toLowerCase();
// }
