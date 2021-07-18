import 'package:flutter/material.dart';
import 'package:device_booking/core/core.dart';

class FeedBack extends StatelessWidget {
  // const FeedBack({Key? key}) : super(key: key);

  UserData user = UserData(
    firstname: 'Pusit',
    lastname: 'Colorbee',
    uid: 'uisdfhkalkfh',
    email: 'pusit@gmail.com',
    inUse: false,
    role: 'Staff',
    photoURL:
        'https://scontent-kut2-2.xx.fbcdn.net/v/t1.6435-9/180606675_3971684062879546_7925887460767274267_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeEDOd4SVieP-DUSuthhgXJgzRYb4dLp1KTNFhvh0unUpI06QN-oodE-_TIFLoPf9G8&_nc_ohc=_UoXjBehMDoAX_OdXcH&_nc_ht=scontent-kut2-2.xx&oh=d128ffc9c19eafd0a1fde8647dd53862&oe=60F35F52',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sadfasdf'),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          children: [Text('สวัสดี Pusit'), Text('sadfasdfasd')],
        ),
      ),
    );
  }
}
