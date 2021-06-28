import 'package:flutter/material.dart';

// class SignInButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 30.0),
//       elevation: 3.0,
//       child: ListTile(
//         onTap: () async{

//         },
//         leading: leadingWidget,
//       ),
//     );
//   }
// }

Widget signInButton({Widget? leading, Text? title}) {
  return LimitedBox(
    maxWidth: 300.0,
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      elevation: 3.0,
      child: ListTile(
        onTap: () async {},
        leading: leading,
        title: title,
      ),
    ),
  );
}

class LogInWithGoogleButton extends StatelessWidget {
  const LogInWithGoogleButton({
    Key? key,
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
            // await AuthService().signOut();
            // Get.toNamed('/loading');
            // await AuthService().signInWithGoogle().then((user) {
            //   user.phoneNumber.length < 10 //Incomplete signup
            //       ? Get.offNamed('/signup')
            //       : Get.back();
            // });
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

//TODO need to add login with apple id later as required by Apple to be allowed to login with other email

// Widget signinWithPhoneNumberDialog() {
//   return Scaffold(
//     appBar: AppBar(),
//     body: Center(
//       child: Text('hi'),
//     ),
//   );
// }
