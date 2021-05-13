import 'package:device_booking/Confirmation/No.dart';
import 'package:device_booking/Confirmation/Yes.dart';
import 'package:flutter/material.dart';
import 'Back.dart';

/*
class ConfiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appBar= AppBar();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Backward()),
              );
            }),
        title: Text("Confirmation"),
        backgroundColor: Colors.blue,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          //padding: const EdgeInsets.all(20.0),
          //color: Colors.white,//yellow,
          height: (MediaQuery.of(context).size.height - appBar.preferredSize.height),
          width: MediaQuery.of(context).size.width -appBar.preferredSize.height ,
          child: Align(
            alignment: Alignment.center,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: const EdgeInsets.all(20.0),
                      color: Colors.lightBlueAccent,
                      width: (MediaQuery.of(context).size.width)/2,
                      height: (MediaQuery.of(context).size.width)/2,
                      child: Image.network('https://picsum.photos/250?image=9')),
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      //color: Colors.white
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'ยืมโดย',
                        style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,),
                      )),
                  Row(
                      children:[
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width)/5,
                            color: Colors.blueGrey,//black12,
                            alignment: Alignment.center,
                            child: Text(
                              'User:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width -appBar.preferredSize.height)-(MediaQuery.of(context).size.width)/5,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: Text(
                              'NAME',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                      ]),
                  Row(
                      children:[
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width)/5,
                            color: Colors.blueGrey,//black12,
                            alignment: Alignment.center,
                            child: Text(
                              'Tel:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width -appBar.preferredSize.height)-(MediaQuery.of(context).size.width)/5,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: Text(
                              'NUMBER',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                      ]),
                  Row(
                      children:[
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width)/5,
                            color: Colors.blueGrey,//black12,
                            alignment: Alignment.center,
                            child: Text(
                              'Time:',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            width:(MediaQuery.of(context).size.width -appBar.preferredSize.height)-(MediaQuery.of(context).size.width)/5,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: Text(
                              'XX:XX',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                      ]),
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      // color: Colors.white,
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'ยืมไปใช้ที่',
                        style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,),
                      )),
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.black12, //blueGrey,
                      alignment: Alignment.center,
                      child: Text(
                        'สถานที่',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    //padding: const EdgeInsets.all(10.0),
                    //color: Colors.white,//purpleAccent,
                      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height)/5,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              padding: const EdgeInsets.all(8.0),
                              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height)/6,
                              width: (MediaQuery.of(context).size.width -appBar.preferredSize.height)/1.5,
                              //  color: Colors.white,//brown,
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Column(children: [
                                    Container(
                                        padding: const EdgeInsets.all(8.0),
                                        //width: 190,
                                        //     color: Colors.white,//orange,
                                        child: Center(
                                            child: Text(
                                              "ต้องการยืนยันหรือไม่ ?",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,),
                                            ))),
                                    Container(
                                      //padding: const EdgeInsets.all(10.0),
                                      //width: 220,
                                      //      color: Colors.white,//pinkAccent,
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  //width: 75,
                                                  //height: 40,
                                                    child: ElevatedButton(
                                                        child: Text("Yes",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16)),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                              Colors.green),
                                                        ),
                                                        onPressed: () => {showAlertDialog(context)}
                                                    )),
                                                SizedBox(
                                                  //width: 75,
                                                  //height: 40,
                                                    child: ElevatedButton(
                                                        child: Text("No",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16)),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                              .redAccent),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => Noo()),
                                                          );
                                                        })),
                                              ],
                                            )))
                                  ])))))
                ]),
          ),
        ),
      ),
    );
  }
}
*/

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pop(); // dismisses only the dialog and returns nothing
      }
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Yess()),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('AlertDialog'),
    content: Text('Would you like to borrow "Device"'),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
