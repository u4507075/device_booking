import 'package:flutter/material.dart';

class ProfileEditWidget extends StatelessWidget {
  final String imagePath;

  const ProfileEditWidget({
    Key key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 1,
            right: 0,
            child: buildEditIcon(color),),
        ],
      )
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

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          )
      )
  );

  Widget buildCircle({
    Widget child,
    double all,
    Color color
  }) => ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );

}