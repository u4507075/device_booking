import 'package:device_booking/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

// void main() => runApp(MyApp());

class GetOTP extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  // final TimerController timerController = Get.put(TimerController());

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // var verificationId = Get.arguments['verificationId'];
  // var resendToken = Get.arguments['resendToken'];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

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

    // return Obx(() {
    // if (timerController.count == 0) {
    //   Get.back();
    //   return Container();
    // } else {
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
            // Obx(() {
            //   return Text(
            //     'Remaining time: ${timerController.count} s',
            //     style: Theme.of(context).textTheme.bodyText2,
            //   );
            // }),
            Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
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
                  if (_formKey.currentState!.validate()) {
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

                      AuthController()
                          .signInWithPhoneNumber(credential)
                          .then((user) {
                        Get.find<LoadingController>().loaded();
                        (user?.isCompleted ?? false)
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
  // },
  // );
}
