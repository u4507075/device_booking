// import 'package:device_booking/widget/qrscanbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_booking/core/core.dart';
import 'package:device_booking/features/features.dart';
import 'package:transparent_image/transparent_image.dart';
import './moreinfo/moreinfo.dart';
import 'package:styled_widget/styled_widget.dart';

class Home extends StatelessWidget {
  // final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    userController
        .fetchUser(); //Todo Add this to future builder, create a group of Future to fetch necessary data before app can be use
    print('Welcome, ${userController.user?.firstname ?? "User"}');
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        elevation: 10.0,
        semanticLabel: 'home_drawer',
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            // DrawerHeader(
            //   margin: const EdgeInsets.all(0.0),
            //   decoration: BoxDecoration(color: Get.theme.primaryColor),
            //   child: Text(
            //     'Medical Device Tracking System',
            //     style: Get.theme.accentTextTheme.headline4,
            //   ),
            // ),
            Obx(
              () => UserAccountsDrawerHeader(
                currentAccountPicture: (userController.user?.photoURL != null
                        ? FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: userController.user!.photoURL!)
                        : Image.asset('assets/images/profile_placeholder.png'))
                    .fittedBox(fit: BoxFit.cover)
                    .clipOval(),
                accountName: Text(
                  userController.user?.firstname ?? '',
                  style: Get.theme.accentTextTheme.bodyText1,
                ),
                accountEmail: Text(
                  userController.user?.phoneNumber ?? '',
                  style: Get.theme.accentTextTheme.bodyText1,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, size: 30.0),
              title:
                  Text('Profile', style: Theme.of(context).textTheme.bodyText1),
              onTap: () {
                Get.back();
                Get.toNamed('/profile');
              },
            ),
            ListTile(
              title: Text(
                'Give us a feedback',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(Icons.announcement, size: 30.0),
              onTap: () {
                Get.back();
                Get.toNamed('/feedback');
              },
            ),
            ListTile(
              leading: Icon(Icons.info, size: 30.0),
              title: Text(
                'More Information',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Get.back();
                moreInfo(context);
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.settings, size: 30.0),
            //   title: Text(
            //     'Tester!',
            //     style: Theme.of(context).textTheme.bodyText1,
            //   ),
            //   onTap: () {
            //     Get.back();
            //     Get.toNamed('tester');
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.settings, size: 30.0),
            //   title: Text(
            //     'Settings',
            //     style: Theme.of(context).textTheme.bodyText1,
            //   ),
            //   onTap: () {},
            // ),
          ],
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 150.0,
          // forceElevated: true,
          // pinned: true,
          snap: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/mdets.jpg',
              fit: BoxFit.cover,
            ),
            collapseMode: CollapseMode.pin,
            centerTitle: true,
            title: Text(
              'Medical Device Tracking System',
              style: Get.theme.accentTextTheme.bodyText1!.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.add_circle),
          //     tooltip: 'Add new entry',
          //     onPressed: () {/* ... */},
          //   ),
          // ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[

          //     IconButton(
          //       onPressed: () {
          //         Get.toNamed('/profile');
          //       },
          //       icon: Icon(Icons.account_circle_sharp),
          //       iconSize: 60,
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20.0,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Text(
          //     'I want to know location of ...',
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //   ),
          // ),
          Divider(),
          GestureDetector(
            onTap: () {
              Get.toNamed('/devicelist', arguments: 'ultrasound');
            },
            child:
                CardButton('Ultrasound', 'assets/images/ultrasound.png', 100.0),
          ),
          SizedBox(
            height: 5.0,
          ),
          Divider(),
          GestureDetector(
              onTap: () {
                Get.toNamed('/devicelist', arguments: 'ekg');
              },
              child: CardButton('EKG', 'assets/images/ekg.png', 100.0)),
          Divider()
        ]))
      ]),
      floatingActionButton: qrScanButtonExtended(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}

class CardButton extends StatelessWidget {
  static const double _edge = 10.0;
  static const double _elevation = 3.0;
  final double _height;
  final String _assetPath;
  final String _title;

  CardButton(this._title, this._assetPath, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: _height,
            alignment: Alignment.center,
            child: ListTile(
              leading: LoadingImageContain(_assetPath, 60.0),
              title: Text(
                _title,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text('Subtitle'),
              isThreeLine: false,
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30,
                color: Colors.grey[300],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingImageContain extends StatelessWidget {
  final _assetPath;
  final _maxSize;

  LoadingImageContain(this._assetPath, this._maxSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: _maxSize),
      child: Image.asset(
        _assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
