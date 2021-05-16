import 'package:flutter/material.dart';
import 'package:device_booking/getotp.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 100.0, bottom: 0.0, left: 50, right: 50),
            child: Image.network('https://upload.wikimedia.org/wikipedia/th/3/37/Logo_MED_TH.png'),),
          Expanded(
              child: Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('Suandok Device Tracking System',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,

                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))))),
          Container(
            margin: const EdgeInsets.only(bottom: 250.0),

            child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0)
                          )
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50, right: 50),
                    child: Text("Log in",
                        style: TextStyle(fontSize: 30)),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return GetOTP();
                    }));
                  },
                )),
          )
        ],
      ),
    );
  }
}