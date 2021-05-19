import 'package:flutter/material.dart';

// class CardStatus extends StatefulWidget {
//   final String device;
//   final GestureTapCallback onPressed;
//   final String name;
//   CardStatus(
//       {Key key,
//       @required this.onPressed,
//       @required this.device,
//       @required this.name})
//       : super(key: key);

//   @override
//   _CardStatusState createState() => _CardStatusState();
// }

// class _CardStatusState extends State<CardStatus> {
//   // String _status = 'available';
//   String _assetPath = '';
//   double _edge = 5.0;
//   String _location = 'Location';

//   _CardStatusState() {
//     if (widget.device == 'ultrasound') {
//       _assetPath = 'assets/images/ultrasonography.png';
//     } else if (widget.device == 'ekg') {
//       _assetPath = 'assets/images/electrocardiogram.png';
//     }
//   } //Todo add not found

//   @override
//   void initState() {
//     super.initState();
//     //for default values
//   }

//  @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: InkWell(
//         onTap: () {
//           widget.onPressed;
//         },
//         child: Card(
//             elevation: 3.0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(_edge)),
//             child: ClipPath(
//               clipper: ShapeBorderClipper(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(_edge))),
//               child: Container(
//                 // height: 80.0,
//                 decoration: BoxDecoration(
//                     border: Border(
//                         left: BorderSide(color: Colors.amber, width: 10.0))),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     ListTile(
//                       leading: LoadingImageContain(_assetPath, 40.0),
//                       title: Text(widget.name),
//                       subtitle: Text(_location),
//                       isThreeLine: false,
//                       trailing: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         size: 30,
//                         color: Colors.grey[300],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )),
//       ),
//     );
//   }
// }

// class CardStatus extends StatefulWidget {
//   final String type;
//   final String name;
//   CardStatus({Key key, this.type, this.name}) : super(key: key);

//   @override
//   _CardStatusState createState() => _CardStatusState();
// }

// class _CardStatusState extends State<CardStatus> {
//   String assetPath = 'assets/images/electrocardiogram.png';
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         onTap: () {},
//         title: Text(widget.name),
//         subtitle: Text('Location'),
//         leading: Image.asset(
//           assetPath,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

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
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
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
