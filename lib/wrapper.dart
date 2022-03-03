
import'package:flutter/material.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:ghana/screens/base_screen.dart';
import 'package:ghana/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/note.dart';

class wrapper extends StatelessWidget {
  final String appBarTitle;
  final Note note;

  wrapper(this. note, this.appBarTitle);
  int a ;
  @override
  Widget build(BuildContext context) {
    _read(context);
    SizeConfig().init(context);
    if (a==50){
      //return QuizPlay();
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => BaseScreen(0),
          transitionDuration: Duration(seconds: 0),
        ),);
    }else{
      print("lol");
      return signup(Note('', '','',1,'','','','', '','','','','','','', '','','','','','','','', '','','','','','','', '','','','','','','', '','','','','','','','',),'');

  }


  }
  _read(context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
     a = value;
    if (a==50){
      //return QuizPlay();
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => BaseScreen(0),
          transitionDuration: Duration(seconds: 0),
        ),);}

  }




}


//  Future build(BuildContext context)async {
//  await Firebase.initializeApp();
//SizeConfig().init(context);
//return either home or authenticate
//return userspage();
//}

