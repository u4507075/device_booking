import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

class PINcode {
  List<Widget> textFields;
  List<String> values;
  StreamController<bool> _controller;
  Widget genTextFields(BuildContext context, StreamController<bool> _controller, int fields, double fontSize, fieldSize) {
    this._controller = _controller;
    values = List<String>(fields);
    textFields = List.generate(fields, (index) {
      return bTextField(context, index, fields, fontSize, fieldSize);
    });

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields
    );
  }

  String getValues(){
    return values.join("");
  }

  Widget bTextField(BuildContext context, i, fields, fontSize, fieldSize) {
    TextEditingController tc = TextEditingController();
    return Container(
      width: fieldSize,
      margin: EdgeInsets.only(right: 2.0),
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 2,
        autofocus: i == 0 ? true : false,
        decoration: InputDecoration(
          hintText: "",
          counterText: "",
        ),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: fontSize),
        controller: tc,
        onChanged:(String str){
          if (str.length>0) {
            tc.text = str.substring(str.length - 1);
            values[i] = str.substring(str.length - 1);
            FocusScope.of(context).nextFocus();
          }
          else{
            tc.text = str;
            values[i] = str;
            FocusScope.of(context).previousFocus();
          }

          if (values.join("").length == fields) {
            _controller.add(true);
          }
          else {
            _controller.add(false);
          }

        },
      ),
    );
  }
}