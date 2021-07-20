import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class LogInWithPhoneButton extends StatefulWidget {
  @override
  _LogInWithPhoneButtonState createState() => _LogInWithPhoneButtonState();
}

class _LogInWithPhoneButtonState extends State<LogInWithPhoneButton> {
  bool pressed = false;
  double borderRadius = 30.0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> submitPhoneNumber(String phoneNumber) async {
      if (_formKey.currentState!.validate()) {
        Get.back();
        Get.dialog(
          LoadingDialog(),
          barrierDismissible: false,
        );
        Get.find<PhoneAuthController>().savePhoneNumber(phoneNumber);
        AuthController().verifyPhoneNumber();
        // //? Close loading dialog after finish authentication
        // Future.delayed(Duration(seconds: 3)).whenComplete(() => Get.back());
      } else {
        print('Invalid phone number');
      }
    }

    void getPhoneNumber() {
      TextEditingController _controller = TextEditingController();
      Get.defaultDialog(
          titleStyle: Get.textTheme.headline6,
          title: 'Log in with phone number',
          content: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    controller: _controller,
                    onFieldSubmitted: (value) async => submitPhoneNumber(value),
                    validator: (value) {
                      String patttern = r'^[0-9]{1}[0-9]{9}$';
                      RegExp regExp = new RegExp(patttern);
                      return !(regExp.hasMatch(value ?? ''))
                          ? 'Must contain 10 digits and start with 0'
                          : null;
                      // return (value == null ||
                      //         value.isEmpty ||
                      //         value.length != 10 ||
                      //         value.substring(0, 1) != '0')
                      //     ? 'Must contain 10 digits and start with 0'
                      //     : null;
                    },
                    decoration: InputDecoration(
                        hintStyle: Get.textTheme.bodyText2!
                            .copyWith(color: Get.theme.hintColor),
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
          onConfirm: () async => submitPhoneNumber(_controller.text));
    }

    Widget card({required Widget child}) => Styled.widget(child: child)
        .padding(vertical: 10, horizontal: 20, animate: true)
        .ripple()
        .backgroundColor(Get.theme.accentIconTheme.color!, animate: true)
        .clipRRect(all: borderRadius)
        .elevation(pressed ? 0 : 10,
            shadowColor: Color(0x30000000),
            borderRadius: BorderRadius.circular(borderRadius))
        .padding(vertical: 10)
        .gestures(
          onTapChange: (tapStatus) => setState(() {
            pressed = tapStatus;
            print(pressed);
          }),

          // onLongPressUp: () =>
          //     launch('tel:${widget.device.lastUserPhoneNumber}'),
          onTap: () => getPhoneNumber(),
          // onTap: () => print('onTap'),
        )
        // .translate(offset: offset, animate: true)
        .scale(all: pressed ? 0.95 : 1, animate: true)
        .animate(Duration(milliseconds: 100), Curves.easeInOutQuad);

    Widget icon = Styled.icon(Icons.phone, animate: true)
        .iconSize(Get.textTheme.headline5!.fontSize!)
        .padding(all: 10)
        .constrained(width: 50, animate: true);

    Widget text = Styled.text('Continue with phone number')
        .textStyle(Get.textTheme.bodyText1!)
        .paddingSymmetric(horizontal: 10);

    return card(
        child: <Widget>[icon, text].toRow(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start));

    return SizedBox(
      width: 250.0,
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
