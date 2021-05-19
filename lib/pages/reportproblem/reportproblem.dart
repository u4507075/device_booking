import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportProblem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          elevation: 0,
          title: Text('Report problem'),
          actions: [
            IconButton(
                icon: Icon(Icons.send),
                tooltip: 'Submit',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Report submitted!')));
                })
          ],
        ),
        body: ReportForm(),
      ),
    );
  }
}

class ReportForm extends StatefulWidget {
  @override
  _ReportForm createState() {
    return _ReportForm();
  }
}

class _ReportForm extends State<ReportForm> {
  static const TextStyle _textfieldstyle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal);
  final String _hintText = 'Enter here';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          TextField(
            style: _textfieldstyle,
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 20,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: _hintText,
            ),
          ),
        ],
      ),
      alignment: Alignment.center,
      //width: MediaQuery.of(context).size.width/1,
      //height: MediaQuery.of(context).size.height/1,
    );
  }
}
