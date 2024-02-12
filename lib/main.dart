import 'package:assistapp/Pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASSISTAPP',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          dialogTheme: DialogTheme(
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color.fromRGBO(38, 152, 207, 1.0),
            selectionColor: Color.fromRGBO(38, 152, 207, 1.0),
            selectionHandleColor: Color.fromRGBO(38, 152, 207, 1.0),

          )
      ),

      home: LoginPage(),
    );
  }
}
