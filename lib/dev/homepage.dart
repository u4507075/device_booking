import 'package:flutter/material.dart';

final Color bgColor = Color.fromARGB(255, 255, 255, 255);
final Color textColor = Color.fromARGB(255, 0, 0, 0);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        body: Center(child: Text('Hello')),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }
}

class bottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      items: [
        new BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        new BottomNavigationBarItem(
            icon: Icon(Icons.swap_horizontal_circle_rounded),
            label: 'Borrow/Return'),
        new BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Log out'),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// final Color bgColor = Color.fromARGB(255, 255, 255, 255);
// final Color textColor = Color.fromARGB(255, 255, 255, 255);

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
//       debugShowCheckedModeBanner: true,
//       home: Scaffold(
//         body: Center(
//           child: Book(),
//         ),
//       ),
//     );
//   }
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       'Hello, World!',
//       style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
//     );
//   }
// }

// class Book extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Padding(
//             padding: EdgeInsets.all(40.0),
//             child: Text('Hello New user!', style: TextStyle(fontSize: 40))),
//         Text('We move under cover and we move as one'),
//         Text('Through the night, we have one shot to live another day'),
//         Text('We cannot let a stray gunshot give us away'),
//         Text('We will fight up close, seize the moment and stay in it'),
//         Text('It’s either that or meet the business end of a bayonet'),
//         Text('The code word is ‘Rochambeau,’ dig me?'),
//         Padding(
//           padding: EdgeInsets.all(40.0),
//           child: ElevatedButton(
//             onPressed: () {},
//             child: Text('Scan QR Code'),
//           ),
//         )
//       ],
//     );
//   }
// }
