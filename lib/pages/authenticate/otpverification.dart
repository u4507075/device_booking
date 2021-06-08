import 'package:device_booking/controller/timer_controller.dart';
import 'package:device_booking/controller/user_controller.dart';
import 'package:device_booking/services/database.dart';
import 'package:device_booking/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void main() => runApp(MyApp());

class GetOTP extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    timerController.countDownSeconds(60);

    return Scaffold(
      appBar: AppBar(title: Text('OTP Verification'), centerTitle: true),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            SizedBox(
              width: 30,
              height: 40,
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2))),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 30,
              height: 40,
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2))),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 30,
              height: 40,
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2))),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 30,
              height: 40,
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2))),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 30,
              height: 40,
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2))),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 30,
              height: 40,
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2))),
              ),
            ),
          ]),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: () async {
                print('${userController.user.phoneNumber}');
                await DBService().registerNewUser(userController.user);
                Get.offAllNamed('/');
              },
              child: Text('Continue')),
          SizedBox(height: 50),
          Text('Resend OTP code')
        ]),
      ),
    );
  }
}
