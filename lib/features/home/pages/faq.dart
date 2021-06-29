import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  String email = 'patipan_s@cmu.ac.th';
  String A =
      'https://www.pinclipart.com/picdir/middle/121-1215914_question-mark-icons-question-mark-in-circle-png.png';
  String B =
      'https://w7.pngwing.com/pngs/298/243/png-transparent-email-address-computer-icons-mail-miscellaneous-angle-triangle-thumbnail.png';
  String P =
      'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png';
  String E =
      'https://i.pinimg.com/originals/af/a7/f2/afa7f20b64c59e9588b5b7b035234eae.jpg';
  TextEditingController _textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
            child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(A),
                ),
                title: Text('FAQs',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Visit our frequently asked questions. These might help you.',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                isThreeLine: true,
                onTap: () => Navigator.pop(context))),
        Card(
          child: ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(B),
              ),
              title: Text('Contact us',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              subtitle: Text(
                "Still can't solve your problem?, contact us directly.",
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: <Widget>[
                Card(
                    child: ListTile(
                  contentPadding: EdgeInsets.only(left: 35.0, right: 0.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(P),
                  ),
                  title: Text('Developer', style: TextStyle(fontSize: 16.0)),
                  subtitle: Text(
                    'ปฏิภาณ สิทธิประเวศ',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  isThreeLine: true,
                )),
                Card(
                    child: ListTile(
                  contentPadding: EdgeInsets.only(left: 35.0, right: 0.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(E),
                  ),
                  title: Text('Email address'),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextButton(
                          child: Text(email),
                          onPressed: () {
                            FlutterClipboard.copy(email).then((result) {
                              final snackBar = SnackBar(
                                content: Text(
                                  email,
                                ),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {},
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            });
                          },
                        )
                      ]),
                  isThreeLine: true,
                )),
              ]),
        ),
      ],
    );
  }
}
