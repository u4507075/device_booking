import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;

  const ProfileWidget({
    Key key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 125,
          height: 125,
        ),
      ),
    );
  }

  Widget buildCircle({
    Widget child,
    double all,
    Color color}) => ClipOval(
  child: Container(
    padding: EdgeInsets.all(all),
    color: color,
    child: child,
  ),
  );

}