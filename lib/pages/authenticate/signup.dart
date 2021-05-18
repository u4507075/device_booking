import 'package:device_booking/models/userform.dart';
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
  final _formKey = GlobalKey<FormState>();
  UserData user; //TODO Delete this after finish

  @override
  void initState() {
    super.initState();
    user = UserData().sample();
    setUserForm();
  }

  @override
  Widget build(BuildContext context) {
    // final Map userMap = ModalRoute.of(context).settings.arguments;
    // UserData user = userMap['user'];
    // print(user);

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
                onPressed: () {
                  print('next');
                  if (_formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(user.firstname)));
                  }
                },
                child: Text(
                  'Next',
                  style: appBarTextStyle,
                ),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ClipOval(
                    child: (user.photoURL != '')
                        ? Image.network(user.photoURL)
                        : Image.asset('assets/images/profile_placeholder.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                  child: Text(user.email, style: b1TextStyle),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: textFormFields(userForm),
                    )),
              ],
            ),
          )),
    );
  }

  Widget textFormField(String collectVar, String labelText, String hintText,
          String errorText) =>
      TextFormField(
          initialValue: collectVar,
          validator: (value) {
            return (value == null || value.isEmpty) ? errorText : null;
          },
          onChanged: (text) {
            collectVar = text;
          },
          decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0))));

  UserTextFormFields userForm;
  setUserForm() {
    userForm = UserTextFormFields([
      UserTextFormField(user.firstname, 'First name', 'Enter your first name',
          'Please enter your first name'),
    ]);
  }

  List<Widget> textFormFields(UserTextFormFields userForm) {
    return userForm.formFields
        .map((formField) => textFormField(formField.collectVar,
            formField.labelText, formField.hintText, formField.errorText))
        .toList();
  }
}
