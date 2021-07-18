import 'package:device_booking/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class GetOTP extends StatefulWidget {
  @override
  _GetOTPState createState() => _GetOTPState();
}

class _GetOTPState extends State<GetOTP> {
  final _formKey = GlobalKey<FormState>();
  bool verifying = false;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
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
      onTap: () =>
          (!currentFocus.hasPrimaryFocus) ? currentFocus.unfocus() : null,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(() => Text(
                  'Your OTP was sent to ${Get.find<PhoneAuthController>().phoneNumber}',
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
                maxLength: 6,
                autofocus: true,
                controller: _controller,
                style: Theme.of(context).textTheme.headline1,
                keyboardType: TextInputType.numberWithOptions(),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    counterText: null,
                    counter: null,
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
            verifying
                ? OutlinedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.grey,
                          strokeWidth: 5,
                        ).scale(all: 0.5),
                        Text('Verifying')
                      ],
                    ))
                : ElevatedButton(
                    onPressed: () async {
                      currentFocus.unfocus();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          verifying = true;
                        });
                        // Get.to(Loading());
                        PhoneAuthController phoneAuthController =
                            Get.put(PhoneAuthController());
                        String _smsCode = phoneAuthController.smsCode;
                        String _verificationId =
                            phoneAuthController.verificationId;
                        print(_smsCode);
                        print(_verificationId);
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: _verificationId,
                                smsCode: _smsCode);
                        try {
                          // UserCredential user =

                          AuthController()
                              .signInWithPhoneNumber(credential)
                              .then((user) {
                            if (user!.isCompleted) {
                              Get.back();
                            } else {
                              Get.back();
                              Get.toNamed('/signup');
                            }
                            print(user);
                            setState(() async {
                              verifying = false;
                            });
                          });
                        } catch (e) {
                          print(e.toString());

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
