//import 'package:device_booking/style.dart';
import 'package:flutter/material.dart';
import './qa.dart';

const String _title = 'FAQ';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(_title),
          ),
          body: Mystful(),
        ),
      ),
    );
  }
}

class Item {

  Item(
      {this.expandedValue = '',
      this.headerValue = '',
      this.isExpanded = false});

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return List<Item>.generate((QA.length) ~/ 2, (int index) {
    return Item(
      headerValue: QA['q$index'] ?? '',
      expandedValue: QA['a$index'] ?? '',
    );
  });
}

class Mystful extends StatefulWidget {
  @override
  _MystfulState createState() => _MystfulState();
}

class _MystfulState extends State<Mystful> {
  final List<Item> _data = generateItems();
  @override
  Widget build(BuildContext context) {
    print(_data);
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    ));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
              // title: Text(QA['q1']),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
            // title: Text(QA['a1']),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
