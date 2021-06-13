import 'dart:ui';
import 'package:device_booking/controller/loading_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class Authenticate extends StatefulWidget {
//   @override
//   _AuthenticateState createState() => _AuthenticateState();
// }

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF02589D),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Medical Device Tracking System',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "\"Medical Device At Your Fingertip\"",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                // LogInWithGoogleButton(),
                // SizedBox(height: 20.0),
                LogInWithPhoneButton(),
              ]),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'since 2021',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}

class LogInWithGoogleButton extends StatelessWidget {
  const LogInWithGoogleButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserData>(context);
    return SizedBox(
      width: 300.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 3.0,
        child: ListTile(
          onTap: () async {
            await AuthService().signOut();
            Get.toNamed('/loading');
            await AuthService().signInWithGoogle().then((user) {
              user.phoneNumber.length < 10 //Incomplete signup
                  ? Get.offNamed('/signup')
                  : Get.back();
            });
          },
          leading: Icon(
            Icons.login_outlined,
            color: Color(0xFF02589D),
            size: 40.0,
          ),
          title: Text('Continue with Gmail \nelearning.cmu.ac.th',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
        ),
      ),
    );
  }
}

class LogInWithPhoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 3.0,
        child: ListTile(
          onTap: () {
            TextEditingController _controller;
            final _formKey = GlobalKey<FormState>();
            String _phoneNumber;
            // UserData _user;
            UserController userController = Get.put(UserController());

            Get.defaultDialog(
                titleStyle: Theme.of(context).textTheme.headline3,
                title: 'Log in with phone number',
                content: Container(
                  padding: const EdgeInsets.all(10.0),
                  // height: 100,
                  // width: 100,
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          // keyboardType: ,
                          // maxLength: 6,
                          keyboardType: TextInputType.phone,
                          controller: _controller,
                          onChanged: (value) {
                            _phoneNumber = value;
                          },
                          validator: (value) {
                            return (value == null ||
                                    value.isEmpty ||
                                    value.length != 10 ||
                                    value.substring(0, 1) != '0')
                                ? 'Must contain 10 digits and start with 0'
                                : null;
                          },
                          decoration: InputDecoration(
                              // labelText: 'Enter Phone Number',
                              // labelStyle: Theme.of(context).textTheme.headline3,
                              hintText: 'Enter Phone Number',
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0))),
                        ),
                      ),
                    ],
                  ),
                ),
                textConfirm: 'Log in',
                confirmTextColor: Colors.white,
                onConfirm: () async {
                  if (_formKey.currentState.validate()) {
                    // print('get phone number: $_phoneNumber');
                    userController.setUser(UserData(phoneNumber: _phoneNumber));
                    print(userController.user.phoneNumber);
                    Get.find<LoadingController>().loading();
                    // Get.toNamed('/loading');

                    AuthService().logInWithPhoneNumber(_phoneNumber);
                    Get.back();
                  } else {
                    print('Invalid phone number');
                  }
                  // Get.back();
                });
          },
          // TODO Apple free developer license can't perform login with phone number, Ref: https://help.apple.com/developer-account/#/dev21218dfd6
          leading: Icon(
            Icons.phone,
            color: Color(0xFF02589D),
            size: 40.0,
          ),
          title: Text('Continue with\nPhone number',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
        ),
      ),
    );
  }
}

//TODO need to add login with apple id later as required by Apple to be allowed to login with other email

// Widget signinWithPhoneNumberDialog() {
//   return Scaffold(
//     appBar: AppBar(),
//     body: Center(
//       child: Text('hi'),
//     ),
//   );
// }
