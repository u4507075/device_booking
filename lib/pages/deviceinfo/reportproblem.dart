import 'package:device_booking/Models/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReportProblem extends StatefulWidget {

  @override
  _ReportProblemState createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  ReportProblemPage Reportproblem = ReportProblemPage();
  StreamController<String> _controller = StreamController.broadcast();
  @override
  void initState() {
    super.initState();
    Reportproblem.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            elevation:0,
            title: StreamBuilder<Object>(
                stream: _controller.stream,
                builder: (context, snapshot)
                {
                  if (snapshot != null &&
                      snapshot.hasData &&
                      snapshot.data == "success") {
                    print(snapshot);
                    print(snapshot.data);
                    print(Reportproblem.Header);
                    return Text(
                      Reportproblem.Header,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return Text(
                      'loading /ja',
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold),
                    );
                  }
                }
            )
        ),
          body: MyCustomForm(),
        )
    );
  }
}
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  ReportProblemPage Reportproblem = ReportProblemPage();

  TextEditingController TextFieldController = new TextEditingController();

  StreamController<String> _controller = StreamController.broadcast();

  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    Reportproblem.fetchAll(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(20.0),child:Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          controller: TextFieldController,
          keyboardType: TextInputType.multiline,
          minLines: 10,
          maxLines: 30,
          decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: 'Enter here',
          ),
        ),
        StreamBuilder<Object>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.hasData &&
                  snapshot.data == "success") {

                return ElevatedButton(
                    child: Text(Reportproblem.Submit),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(context);
                      //Updatedata from TextFieldController.text
                      updateData();
                    }
                );
              }
              else {
                return ElevatedButton(
                    child: Text('submit'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(context);
                      updateData();
                    }
                    );
            }
            }
        ),
      ],

      //width: MediaQuery.of(context).size.width/1,
      //height: MediaQuery.of(context).size.height/1,
    ),
      alignment: Alignment.center,
    );
  }
  void updateData() {
    try {
      databaseReference.collection('device')
          .doc('uqxXjSEU2JpgXpcaJfPF')
          .update({'problem': FieldValue.arrayUnion([TextFieldController.text])});
    } catch (e) {
      print(e.toString());
    }
  }

}
//---------------------------------------------------
// class submit extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 61, 76, 100)),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: MyWidget(),
//         ),
//       ),
//     );
//   }
// }
//
// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Text('Submitted!!', style: Theme.of(context).textTheme.headline4);
//   }
// }

