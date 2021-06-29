import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';
import 'package:get/get.dart';

class LogInWithPhoneButton extends StatelessWidget {
  // var _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    void getPhoneNumber() {
      final _formKey = GlobalKey<FormState>();
      TextEditingController _controller = TextEditingController();
      String _phoneNumber = '';
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
                    autofocus: true,
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
            if (_formKey.currentState!.validate()) {
              // print('get phone number: $_phoneNumber');
              // _userController.setUser(UserData(phoneNumber: _phoneNumber));
              // print(_userController.user?.phoneNumber);
              Get.find<PhoneAuthController>().savePhoneNumber(_phoneNumber);

              Get.find<LoadingController>().loading();
              // Get.toNamed('/loading');

              AuthController().verifyPhoneNumber(_phoneNumber);
              Get.back();
            } else {
              print('Invalid phone number');
            }
            // Get.back();
          });
    }

    return SizedBox(
      width: 300.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 3.0,
        child: ListTile(
          onTap: () {
            getPhoneNumber();
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
