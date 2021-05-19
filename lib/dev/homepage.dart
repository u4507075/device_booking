import 'package:flutter/material.dart';

final Color bgColor = Color.fromARGB(255, 255, 255, 255);
final Color textColor = Color.fromARGB(255, 0, 0, 0);

// void main() {
//   runApp(MyApp());
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: true,
      title: 'MED CMU Tracker',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Medical Device Tracker'), /*bottom: TopBar()*/
          ),
          body: Center(child: ListBody()),
          bottomNavigationBar: BottomBar(),
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  @override
  _BottomBar createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle unselectedstyle = TextStyle(
    fontSize: 16,
  );
  static const TextStyle selectedstyle = TextStyle(
    fontSize: 20,
  );

  var bottomNavigationBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.location_on), label: 'Device location'),
    BottomNavigationBarItem(
        icon: Icon(Icons.swap_horizontal_circle_rounded),
        label: 'Borrow/Return',
        backgroundColor: Color.fromARGB(255, 255, 255, 255)),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_rounded), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      items: bottomNavigationBarItems,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      iconSize: 40,
      unselectedLabelStyle: unselectedstyle,
      selectedLabelStyle: selectedstyle,
      showUnselectedLabels: false,
    );
  }
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final tabBarItems = <Tab>[
    Tab(
      text: 'All',
    ),
    Tab(text: 'U/S'),
    Tab(text: 'EKG'),
  ];
  Size get preferredSize => const Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {
    return TabBar(tabs: tabBarItems);
  }
}

class ListSeperate extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: entries.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Text('${entries[index]}'),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    ));
  }
}

class ListBody extends StatelessWidget {
  static const title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  static const available = TextStyle(
    color: Colors.teal,
    fontSize: 14,
  );
  static const busy = TextStyle(
    color: Colors.deepOrange,
    fontSize: 14,
  );
  static const maintenance = TextStyle(
    color: Colors.amber,
    fontSize: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(padding: EdgeInsets.all(20), children: <Widget>[
        for (int index = 1; index < 11; index++)
          Card(
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: ListTile(
                      leading: Icon(
                        Icons.wifi,
                        size: 40,
                      ),
                      title: Text(
                        'Ultrasound No.$index',
                        style: title,
                      ),
                      subtitle: Text(
                        'Available',
                        style: available,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  )))
      ]),
    );
  }
}

class CardTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Text(
            'A card that can be tapped',
            textAlign: TextAlign.center,
          ),
        ),
      ),
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
