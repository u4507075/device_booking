import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PINcode extends StatelessWidget {
  List<Widget> textFields;

  Widget genTextFields(BuildContext context, int fields, double fontSize, fieldSize) {
    textFields = List.generate(fields, (index) {
      return bTextField(context, index, fields, fontSize, fieldSize);
    });

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields
    );
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
          tc.text = str.substring(str.length-1);
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}