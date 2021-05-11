import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key key,
    this.text,
    this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        child: TextField(
          style: TextStyle(color: Colors.grey),
          decoration: InputDecoration(border: InputBorder.none),
          controller: controller,
        ),
      )
    ],
  );
}