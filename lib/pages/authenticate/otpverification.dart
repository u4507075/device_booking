import 'package:device_booking/controller/auth_controller.dart';
import 'package:device_booking/controller/loading_controller.dart';
import 'package:device_booking/controller/phoneauth_controller.dart';
import 'package:device_booking/controller/timer_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/models/user.dart';
import 'package:device_booking/services/auth.dart';
import 'package:device_booking/services/database.dart';
import 'package:device_booking/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

// void main() => runApp(MyApp());

class GetOTP extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final TimerController timerController = Get.put(TimerController());

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // var verificationId = Get.arguments['verificationId'];
  // var resendToken = Get.arguments['resendToken'];

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
//     return Obx(() {
//       if (Get.find<TimerController>().timeout) {
//         Get.snackbar('Time out', 'Please try to log in again');
//         SchedulerBinding.instance.addPostFrameCallback((_) {
//           Get.back(); //ref: https://stackoverflow.com/questions/55618717/error-thrown-on-navigator-pop-until-debuglocked-is-not-true
//         });
// //         Future.delayed(Duration.zero, () {
// //   Get.back();
// // });
//         return Scaffold();
//       } else {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(() => Text(
                  'Your OTP was sent to ${userController.user?.phoneNumber}',
                  style: Theme.of(context).textTheme.bodyText2,
                )),
            Obx(() {
              return Text(
                'Remaining time: ${timerController.count} s',
                style: Theme.of(context).textTheme.bodyText2,
              );
            }),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                style: Theme.of(context).textTheme.headline1,
                keyboardType: TextInputType.numberWithOptions(),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 1))),
                onChanged: (code) {
                  Get.find<PhoneAuthController>().saveCode(code);
                },
                validator: (value) {
                  return (value == null || value.isEmpty || value.length != 6)
                      ? 'Must contain 6 digits'
                      : null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Get.find<LoadingController>().loading();
                  if (_formKey.currentState.validate()) {
                    PhoneAuthController phoneAuthController =
                        Get.put(PhoneAuthController());
                    String _smsCode = phoneAuthController.smsCode;
                    String _verificationId = phoneAuthController.verificationId;
                    print(_smsCode);
                    print(_verificationId);
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: _verificationId, smsCode: _smsCode);
                    try {
                      // UserCredential user =

                      AuthService()
                          .signInWithPhoneNumber(credential)
                          .then((user) {
                        Get.find<LoadingController>().loaded();
                        UserData().isCompleted(user)
                            ? Get.back()
                            : Get.offNamed('/signup');
                        print(user);
                      });
                    } catch (e) {
                      print(e.toString());
                      Get.find<LoadingController>().loaded();
                      // Get.snackbar('Log In failed', '${e.toString()}');
                    }

                    // // Get.back();
                  }
                },
                child: Text('Verify OTP')),
          ],
        )),
      ),
    );
  }
}
// return Scaffold(
//   appBar: AppBar(title: Text('OTP Verification'), centerTitle: true),
//   body: Center(
//     child:
//         Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//       Obx(() => Text(
//             'Your OTP was sent to ${userController.user?.phoneNumber}',
//             style: Theme.of(context).textTheme.bodyText2,
//           )),
//       Obx(() {
//         return Text(
//           'Remaining time: ${timerController.count} s',
//           style: Theme.of(context).textTheme.bodyText2,
//         );
//       }),
//       Form(
//         key: _formKey,
//         child: TextFormField(
//           controller: _controller,
//           style: Theme.of(context).textTheme.headline1,
//           keyboardType: TextInputType.number,
//           textAlign: TextAlign.center,
//           decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black26, width: 1))),
//           onChanged: (code) {
//             Get.find<PhoneAuthController>().saveCode(code);
//           },
//           validator: (value) {
//             return (value == null || value.isEmpty || value.length != 6)
//                 ? 'Must contain 6 digits'
//                 : null;
//           },
//         ),
//       ),
//       SizedBox(height: 50),
//       ElevatedButton(
//           onPressed: () async {
//             if (_formKey.currentState.validate()) {
//               print('${userController.user.phoneNumber}');
//               PhoneAuthController phoneAuthController =
//                   Get.put(PhoneAuthController());
//               String _smsCode = phoneAuthController.smsCode;
//               String _verificationId = phoneAuthController.verificationId;

//               PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                   verificationId: _verificationId, smsCode: _smsCode);
//               try {
//                 UserCredential user =
//                     await _auth.signInWithCredential(credential);
//                 print(1);
//                 await DBService().registerNewUser(userController.user);
//               } catch (e) {
//                 print(e.toString());
//                 // Get.snackbar('Log In failed', '${e.toString()}');
//               }

//               // Get.back();
//             }
//           },
//           child: Text('test')),
//       Text('Resend OTP code')
//     ]),
//   ),
// );
