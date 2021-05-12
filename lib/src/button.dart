import 'package:flutter/material.dart';

class CardStatus extends StatefulWidget {
  final String device;
  final GestureTapCallback onPressed;
  CardStatus({Key key, @required this.onPressed, @required this.device})
      : super(key: key);

  @override
  _CardStatusState createState() => _CardStatusState(device, onPressed);
}

class _CardStatusState extends State<CardStatus> {
  final String _device;
  final GestureTapCallback _onPressed;
  String _status = 'available';
  String _assetPath = '';
  String _title = 'Device name Default'; //TODO: Add Icon not found
  double _elevation = 3.0;
  double _edge = 5.0;
  String _location = 'Location';

  _CardStatusState(this._device, this._onPressed) {
    if (_device == 'ultrasound') {
      _assetPath = 'assets/images/ultrasonography.png';
      _title = 'Ultrasound';
    } else if (_device == 'ekg') {
      _assetPath = 'assets/images/electrocardiogram.png';
      _title = 'EKG';
    }
  }

  @override
  void initState() {
    super.initState();
    //for default values
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          _onPressed;
        },
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
                      title: Text(_title),
                      subtitle: Text(_location),
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
      ),
    );
  }
}

class CardStatus2 extends StatelessWidget {
  static const double _edge = 10.0;
  static const double _elevation = 3.0;
  final double _height = 100.0; //TODO add inheritwidget
  // String _assetPath;
  String _assetPath;
  final String _title;

  CardStatus2(this._title, this._assetPath);

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
                    title: Text(_title),
                    subtitle: Text('Location'),
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
