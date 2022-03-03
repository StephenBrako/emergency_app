import 'package:flutter/material.dart';
import 'package:ghana/screens/base_screen.dart';
import 'package:ghana/wrapper.dart';

import 'data/note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Poppins",
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        primarySwatch: Colors.blue,
      ),
      home: wrapper(Note('', '','',1,'','','','', '','','','','','','', '','','','','','','','', '','','','','','','', '','','','','','','', '','','','','','','','',),''),

    );
  }
}
