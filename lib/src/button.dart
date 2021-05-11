import 'package:flutter/material.dart';

//1. CardButton with status bar on the right side
// class CardButton extends StatelessWidget {
//   final double _height;
//   static const String _assetPath =
//       'package:device_booking/assets/images/ultrasonography.png';
//   static const double _edge = 3.0;
//   static const double _elevation = 3.0;

//   CardButton(this._height);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//           elevation: _elevation,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(_edge)),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               ListTile(
//                 leading: Container(
//                     constraints: BoxConstraints.expand(height: 30),
//                     child: Icon(Icons.accessibility_new_sharp)),
//                 // child: Image(
//                 //     image: AssetImage(_assetPath), fit: BoxFit.cover)),
//                 title: Text('Ultrasound'),
//                 subtitle: Text('อายุรกรรมชาย'),
//               )
//             ],
//           )),
//     );
//   }
// }

// class CardStatus extends StatelessWidget {
//   final double _height;
//   final Color _color;
//   static const double _edge = 3.0;
//   static const double _elevation = 3.0;

//   // double _height;
//   // Color _color;

//   // CardButton(double _height, Color _color) {
//   //   this._height = _height;
//   //   this._color = _color;
//   // }

//   CardStatus(this._height, this._color);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: _elevation,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_edge)),
//       child: ClipPath(
//         child: Container(
//           height: _height,
//           // decoration: BoxDecoration(
//           //     border: Border(right: BorderSide(color: _color, width: 10))),
//         ),
//         clipper: ShapeBorderClipper(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(_edge))),
//       ),
//     );
//   }
// }

class CardStatus extends StatelessWidget {
  static const double _edge = 10.0;
  static const double _elevation = 3.0;
  final String _assetPath = 'assets/images/ultrasonography.png';
  // final String _device;
  // CardStatus(this._device);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          elevation: _elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_edge)),
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_edge))),
            child: Container(
              // height: 80.0,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Colors.amber, width: 10.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    leading: LoadingImageContain(_assetPath, 40.0),
                    title: Text('Title'),
                    subtitle: Text('Subtitle'),
                    isThreeLine: false,
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30,
                      color: Colors.grey[300],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
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
      child: Card(
          elevation: _elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_edge)),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
          )),
    );
  }
}

// class CardStatus2 extends StatelessWidget {
//   static const double _edge = 3.0;
//   static const double _elevation = 3.0;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//           elevation: _elevation,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(_edge)),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               ListTile(
//                 leading: LoadingImageContain(
//                     "assets/images/ultrasonography.png", 40.0),
//                 title: Text('Title'),
//                 subtitle: Text('Subtitle'),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 30,
//                   color: Colors.grey[300],
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }

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
