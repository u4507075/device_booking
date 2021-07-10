import 'package:flutter/material.dart';
import 'core/core.dart';
import 'navigation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppInitialize());
}

class AppInitialize extends StatefulWidget {
  @override
  _AppInitializeState createState() => _AppInitializeState();
}

class _AppInitializeState extends State<AppInitialize> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return InitializeError();
        } // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return App();
        } // Otherwise, show something whilst waiting for initialization to complete
        // return GetMaterialApp(home: Loading());
        return MaterialApp(
          home: Loading(),
        );
      },
    );
  }
}

class InitializeError extends StatelessWidget {
  const InitializeError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: InitializeErrorPage(),
    );
  }
}

class InitializeErrorPage extends StatelessWidget {
  const InitializeErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Error initializaing app')),
    );
  }
}
