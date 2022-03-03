import 'package:flutter/material.dart';
import 'package:ghana/constants/color_constants.dart';
import 'package:ghana/screens/updatecard.dart';
import 'package:ghana/screens/home_Screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghana/screens/newspage.dart';
import 'package:ghana/screens/shopspage.dart';
import 'package:ghana/data/database_helper.dart';
import 'package:ghana/data/note.dart';

import 'card_screen.dart';

class BaseScreen extends StatefulWidget {
  final int value;
   BaseScreen(this.value,{Key key}) : super(key: key);


  @override
  _BaseScreenState createState() => _BaseScreenState(this.value);
}

class _BaseScreenState extends State<BaseScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int value;
  _BaseScreenState(this.value);
  List<Note> noteList;
  int _selectedIndex = 0;
  int serve=0;

  void initState(){
    super.initState();
    _changewidgetindex();
  }

  final List<Widget> _widgetOptions = <Widget>[

  ];
  @override

  Widget build(BuildContext context) {
    return Scaffold(


      body: IndexedStack(
          index: _selectedIndex ,
          children: <Widget>[
            HomeScreen(Note('', '','',1,'','','','', '','','','','','','', '','','','','','','','', '','','','','','','', '','','','','','','', '','','','','','','','',),''),
            CardScreen(Note('', '','',1,'','','','', '','','','','','','', '','','','','','','','', '','','','','','','', '','','','','','','', '','','','','','','','',),''),
            Home(),
            SettingScreen(),


          ]
      ),

      bottomNavigationBar: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home,), label: "Home",),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.creditCard), label: "ID Cards"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.newspaper), label: "News"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.shoppingCart), label: "Shop")

          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              serve=0;
              _selectedIndex = index;
            });
          }),
    );
  }
  void _changewidgetindex(){
    serve=widget.value;
    if(serve==1){
      setState(() {
        _selectedIndex=1;
      });
    }

  }


}
