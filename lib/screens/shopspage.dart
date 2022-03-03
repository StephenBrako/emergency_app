import 'package:flutter/material.dart';
import 'package:ghana/data/note.dart';
import 'package:ghana/screens/shopscontent.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int currentIndex = 0;
  Note note;
  String appBarTitle;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Map<String, List> newsData = Map<String, List>();
  bool isLoading = true;
  getData() async {
    setState(() {
      isLoading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : <Widget>[
        HomePage(),

      ][currentIndex],

    );
  }


}
