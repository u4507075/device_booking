import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class StyledWidgetTest extends StatefulWidget {
  // const StyledWidgetTest({Key? key}) : super(key: key);
//
  @override
  _StyledWidgetTestState createState() => _StyledWidgetTestState();
}

class _StyledWidgetTestState extends State<StyledWidgetTest> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    final customizedButton =
        ({required Widget child}) => Styled.widget(child: child)
            .center()
            .borderRadius(all: 15)
            .ripple()
            .backgroundColor(Colors.cyanAccent)
            .clipRRect(all: 25)
            .borderRadius(all: 25, animate: true)
            .gestures(
              onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
              onTapDown: (details) => print('tapDown'),
              onTap: () => print('onTap'),
            )
            .scale(all: pressed ? 0.5 : 0.6, animate: true)
            .animate(Duration(milliseconds: 1000), Curves.easeOut);

    final settingsItem =
        ({required Widget child}) => Styled.widget(child: child)
            .alignment(Alignment.center)
            .borderRadius(all: 15)
            .ripple()
            .backgroundColor(Colors.white, animate: true)
            .clipRRect(all: 25) // clip ripple
            .borderRadius(all: 25, animate: true)
            .elevation(
              pressed ? 0 : 20,
              borderRadius: BorderRadius.circular(25),
              shadowColor: Color(0x30000000),
            ) // shadow borderRadius
            .constrained(height: 100)
            .padding(vertical: 12) // margin
            .gestures(
              onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
              onTapDown: (details) => print('tapDown'),
              onTap: () => print('onTap'),
            )
            .scale(all: pressed ? 0.95 : 1.0, animate: true)
            .animate(Duration(milliseconds: 150), Curves.easeOut)
            .opacity(0.5);

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(child: Text('Test').parent(settingsItem)));
  }
}
