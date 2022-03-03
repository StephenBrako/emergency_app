import 'package:flutter/material.dart';
import 'package:ghana/screens/newscontent.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

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
        HomePage(
        ),

      ][currentIndex],

    );
  }


}
