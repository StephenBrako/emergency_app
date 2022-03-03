import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ghana/data/note.dart';
import 'package:ghana/data/database_helper.dart';
import 'package:ghana/screens/updatecard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:ghana/constants/color_constants.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ghana/data/database_helper.dart';
import 'package:ghana/data/note.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghana/screens/shopspage.dart';
import 'package:sqflite/sqflite.dart';


class CardScreen extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  CardScreen(this. note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return CardScreenState(this.note, this.appBarTitle);
  }
}

class CardScreenState extends State<CardScreen> {
  static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;
  int result;

  CardScreenState(this.note, this.appBarTitle);

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  Uint8List _bytesImagesnnit;
  Uint8List _bytesImagenhis;
  Uint8List _bytesImageghcard;
  Uint8List _bytesImagevoterid;
  Uint8List _bytesImagelicence;

  void initState(){
    super.initState();
   /* note.title="rr";

    note.snnitpicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";
    note.ghcardpicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";

    note.voteridpicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";

    note.licencepicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";

    note.nhispicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";
    helper.insertNote(note);

*/


    /* if (note.snnitpicture == null) {
      note.snnitpicture =
      "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";
    }//11
    else{
      note.snnitpicture=noteList[0].snnitpicture;}*/
  }


  @override
  Widget build(BuildContext context) {
   //

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    _bytesImagesnnit = Base64Decoder().convert(noteList[0].snnitpicture);
    _bytesImagelicence = Base64Decoder().convert(noteList[0].licencepicture);
    _bytesImagenhis = Base64Decoder().convert(noteList[0].nhispicture);
    _bytesImageghcard = Base64Decoder().convert(noteList[0].ghcardpicture);
    _bytesImagevoterid = Base64Decoder().convert(noteList[0].voteridpicture);


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My National ID Cards",//voters id, passport, license,snnit
          style: TextStyle(
            fontFamily: "Poppins",
            color: kPrimaryColor,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage:
            AssetImage("assets/flag.png"),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.userCog,
                color: Colors.black87,
                size: 26,
              ),
              onPressed: () {
                setState(() {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) => NoteDetail(noteList[0], " k")),(route) => false);

                });});
              })
        ],
      ),

      body: Container(
          color: Colors.white,

          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[500].withOpacity(1.0),
                      offset: Offset(1.0, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF9fd8fb),
                      Color(0xFFB90E0A),
                      Color(0xFF9fd8fb),
                      Color(0xFF9fd8fb),
                      Color(0xFFF6E8B1),
                      Color(0xFFF6E8B1),
                      Color(0xFFa3e4d7),
                    ],
                    stops: [0.18, 0.08,0.2, 0.17, 0.26,0.7, 1],
                  ),
                ),

                height: SizeConfig.safeBlockVertical*35,
                width: SizeConfig.safeBlockHorizontal*100,

                child: Container(

                  child: Column(
                    children: [
                      Container(

                        width: SizeConfig.safeBlockHorizontal*92,
                        height: SizeConfig.safeBlockVertical*6,
                        child: Image.asset('assets/ghcard.png'),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal*0.01,
                            ),



                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Surname/Nom:",
                                      style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].ghcardsurname}",
                                      style: TextStyle(fontSize: 13,color:Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Firstnames/Prenoms:",
                                      style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].ghcardfirstname}",
                                      style: TextStyle(fontSize: 13,color:Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Previous Name(s)/Noms Precedents:",
                                      style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].ghcardpreviousname}",
                                      style: TextStyle(fontSize: 13,color:Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nationality/Nationalité",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcardnationality}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal*5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sex/Sexe",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcardsex}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date of Birth",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcarddateofbirth}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal*5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Place of Issuance",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcardplaceofissuance}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Personal ID Number",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcardid}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal*5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Height/Taille(m)",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcardheight}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date of Issuance",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcarddateofissuance}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal*5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date of Expiry",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].ghcarddateofexpiry}",
                                          style: TextStyle(fontSize: 13,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                )

                              ],
                            ),

                            Column(children: [
                              Container(

                                width:  SizeConfig.safeBlockHorizontal * 30,

                                height: SizeConfig.safeBlockVertical * 20,

                                decoration: BoxDecoration(

                                  color: Color(0xFF9fd8fb),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.1),
                                        blurRadius: 8,
                                        spreadRadius: 3)
                                  ],
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                padding: EdgeInsets.all(1),
                                child: Container(

                                  child:  Image.memory(_bytesImageghcard),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Document Number",
                                    style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                  ),
                                  Text(
                                    "${noteList[0].ghcarddocumentnumber}",
                                    style: TextStyle(fontSize: 13,color:Colors.black),
                                  ),
                                ],
                              ),

                            ],)


                          ],
                        ),

                      )
                    ],

                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.safeBlockVertical*2,
              ),Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[500].withOpacity(1.0),
                      offset: Offset(1.0, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF09143C),
                      Color(0xFFFFFFFF),
                      Color(0xFF7EF9FF),
                      Color(0xFF00C5CD),
                      Color(0xFF00C5CD),
                      Color(0xFF00C5CD),
                      Color(0xFF00C5CD),
                    ],
                    stops: [0.209, 0.205,0.24, 0.17, 0.7,0.4, 0.9],
                  ),
                ),

                height: SizeConfig.safeBlockVertical*29,
                width: SizeConfig.safeBlockHorizontal*100,

                child: Container(

                  child: Column(
                    children: [
                      Container(

                        width: SizeConfig.safeBlockHorizontal*100,
                        height: SizeConfig.safeBlockVertical*6.8,
                        child: Image.asset('assets/nhis.png'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child:  Row(

                          children: [

                            Container(

                              width:  SizeConfig.safeBlockHorizontal * 29,

                              height: SizeConfig.safeBlockVertical * 19,

                              decoration: BoxDecoration(

                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 8,
                                      spreadRadius: 3)
                                ],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              padding: EdgeInsets.all(1),
                              child: Container(

                                child:  Image.memory(_bytesImagenhis),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal*2,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NAME:",
                                      style: TextStyle(fontSize: 12,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].nhisname}",
                                      style: TextStyle(fontSize: 14,color:Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "DATE OF BIRTH:",
                                      style: TextStyle(fontSize: 12,color:Color(0xFF000080)),
                                    ),
                                    Text(
                                      "${noteList[0].nhisdateofbirth}",
                                      style: TextStyle(fontSize: 14,color:Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.5,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "MEMBERSHIP No:",
                                          style: TextStyle(fontSize: 12,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].nhisid}",
                                          style: TextStyle(fontSize: 14,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "SEX:",
                                          style: TextStyle(fontSize: 12,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].nhissex}",
                                          style: TextStyle(fontSize: 14,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.5,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "DATE OF ISSUE:",
                                          style: TextStyle(fontSize: 12,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].nhisdateofissuance}",
                                          style: TextStyle(fontSize: 14,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "EXPIRY DATE:",
                                          style: TextStyle(fontSize: 12,color:Color(0xFF000080)),
                                        ),
                                        Text(
                                          "${noteList[0].nhisdateofexpiry}",
                                          style: TextStyle(fontSize: 14,color:Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ],
                        ),

                      )
                    ],

                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.safeBlockVertical*2,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[500].withOpacity(1.0),
                      offset: Offset(1.0, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFCCCC),
                      Color(0xFFFF9999),
                      Color(0xFFFFCCCC),
                      Color(0xFFFF9999),
                      Color(0xFFFfffff),
                      Color(0xFFFFcccc),
                      Color(0xFFd7fff7),
                    ],
                    stops: [0.18, 0.08,0.2, 0.17, 0.26,0.7, 1],
                  ),
                ),

                height: SizeConfig.safeBlockVertical*33.5,
                width: SizeConfig.safeBlockHorizontal*100,

                child: Container(
                  padding: EdgeInsets.all(7),

                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(

                            width:  SizeConfig.safeBlockHorizontal * 30,

                            height: SizeConfig.safeBlockVertical * 20,

                            decoration: BoxDecoration(

                              color: Color(0xFF9fd8fb),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 8,
                                    spreadRadius: 3)
                              ],
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: EdgeInsets.all(2),
                            child: Container(

                              child:  Image.memory(_bytesImagelicence),
                            ),
                          ),
                        ],

                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal*1,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "REPUBLIC OF GHANA",
                                    style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.w900),
                                  ),


                                  Text(
                                    "DRIVER LICENCE",
                                    style: TextStyle(fontSize: 16,color:Colors.black, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),


                              Container(
                                width: SizeConfig.safeBlockHorizontal*18,

                                height: SizeConfig.safeBlockVertical*5,
                                child: Image.asset('assets/coatofarms.png'),
                              ),
                            ],

                          ),



                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Name:",
                                  style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                              ),

                              Text(
                                "${noteList[0].licencename}",
                                style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Date of Birth",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].licencedateofbirth}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal*5
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Licence Number9",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].licencepin}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Processing Center",
                                  style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                              ),

                              Text(
                                "${noteList[0].licenceprocessingcenter}",
                                style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "Class of Licence:  ",
                                  style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                              ),
                              Text(
                                  "${noteList[0].licenceclass}",
                                  style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700)
                              ),

                            ],
                          ),

                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "National ID No",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].licencenationalid}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal*5
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Nationality",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].licencenationality}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Date of Issue",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].licencedateofissue}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal*2
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Expiry Date",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].licencedateofexpiry}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),


                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Certificate Date",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].licencecertificatedate}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal*5
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Reference Number",
                                      style: TextStyle(fontSize: 11,color:Colors.red,fontWeight: FontWeight.w600)
                                  ),

                                  Text(
                                    "${noteList[0].certificateofcompetence}",
                                    style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),



                        ],

                      ),




                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical*2,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[500].withOpacity(1.0),
                      offset: Offset(1.0, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFffa80f),
                      Color(0xFFffa80f),
                      Color(0xFFffa80f),
                      Color(0xFFffa80f),
                      Color(0xFFffcf07),
                      Color(0xFFffa80f),
                      Color(0xFFffa80f),
                    ],
                    stops: [0.18, 0.23,0.17, 0.17, 0.26,0.7, 1],
                  ),
                ),

                height: SizeConfig.safeBlockVertical*30,
                width: SizeConfig.safeBlockHorizontal*100,

                child: Container(

                  child: Column(
                    children: [
                      Container(

                        width: SizeConfig.safeBlockHorizontal*100,
                        height: SizeConfig.safeBlockVertical*7.4,
                        child: Image.asset('assets/snnit.png'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal*0.01,
                            ),



                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Snnit Number",
                                      style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].snnitid}",
                                      style: TextStyle(fontSize: 18,color:Colors.black, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].snnitname}",
                                      style: TextStyle(fontSize: 13,color:Colors.black,fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Gender",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),

                                        Text(
                                          "${noteList[0].snnitgender}",
                                          style: TextStyle(fontSize: 13,color:Colors.black,fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal*5
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date of Birth",
                                          style: TextStyle(fontSize: 10,color:Color(0xFF000080)),
                                        ),

                                        Text(
                                          "${noteList[0].snnitdateofbirth}",
                                          style: TextStyle(fontSize: 13,color:Colors.black,fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),


                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),


                              ],
                            ),

                            Container(

                              width:  SizeConfig.safeBlockHorizontal * 30,

                              height: SizeConfig.safeBlockVertical * 20,

                              decoration: BoxDecoration(

                                color: Color(0xFF9fd8fb),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 8,
                                      spreadRadius: 3)
                                ],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              padding: EdgeInsets.all(1),
                              child: Container(

                               child: Image.memory(_bytesImagesnnit),


                              ),
                            ),


                          ],
                        ),

                      )
                    ],

                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical*2,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[500].withOpacity(1.0),
                      offset: Offset(1.0, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEBECF0),
                      Color(0xFFEBECF0),
                      Color(0xFFEBECF0),
                      Color(0xFFEBECF0),
                      Color(0xFFEBECF0),
                      Color(0xFFEBECF0),
                      Color(0xFFEBECF0),
                    ],
                    stops: [0.18, 0.23,0.17, 0.17, 0.26,0.7, 1],
                  ),
                ),

                height: SizeConfig.safeBlockVertical*31,
                width: SizeConfig.safeBlockHorizontal*100,

                child: Container(
                  padding: EdgeInsets.all(10),

                  child: Column(
                    children: [
                      Row(

                        children: [
                          Container(


                            height: SizeConfig.safeBlockVertical*4.8,
                            child: Image.asset('assets/coatofarms.png'),
                          ),
                          Column(
                            children: [
                              Text(
                                "  ELECTORAL COMMISSION OF GHANA  ",
                                style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "  VOTER CARD  ",
                                style: TextStyle(fontSize: 16,color:Colors.black,fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Container(


                            height: SizeConfig.safeBlockVertical*4,
                            child: Image.asset('assets/flag.png'),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical*1,
                      ),

                      Container(

                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,


                          children: [

                            Container(

                              width:  SizeConfig.safeBlockHorizontal * 30,

                              height: SizeConfig.safeBlockVertical * 20,

                              decoration: BoxDecoration(

                                color: Color(0xFF9fd8fb),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 8,
                                      spreadRadius: 3)
                                ],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              padding: EdgeInsets.all(1),
                              child: Container(

                                child:  Image.memory(_bytesImagevoterid),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal*2,
                            ),



                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Surname",
                                      style: TextStyle(fontSize: 11,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].voteridsurname}",
                                      style: TextStyle(fontSize: 14,color:Colors.black, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Othernames",
                                      style: TextStyle(fontSize: 11,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].voteridothername}",
                                      style: TextStyle(fontSize: 14,color:Colors.black, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sex",
                                          style: TextStyle(fontSize: 11,color:Color(0xFF000080)),
                                        ),

                                        Text(
                                          "${noteList[0].voteridsex}",
                                          style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal*12
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date of Birth",
                                          style: TextStyle(fontSize: 11,color:Color(0xFF000080)),
                                        ),

                                        Text(
                                          "${noteList[0].voteriddateofbirth}",
                                          style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),


                                SizedBox(
                                  height: SizeConfig.safeBlockVertical*0.1,
                                ),

                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Polling St. Code",
                                          style: TextStyle(fontSize: 11,color:Color(0xFF000080)),
                                        ),

                                        Text(
                                          "${noteList[0].voteridpollingstationcode}",
                                          style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal*3
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date of Registration",
                                          style: TextStyle(fontSize: 11,color:Color(0xFF000080)),
                                        ),

                                        Text(
                                          "${noteList[0].voteriddateofregistration}",
                                          style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Voter Identification Number",
                                      style: TextStyle(fontSize: 11,color:Color(0xFF000080)),
                                    ),

                                    Text(
                                      "${noteList[0].voteridnumber}",
                                      style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),



                              ],
                            ),



                          ],
                        ),

                      )
                    ],

                  ),
                ),
              ),

            ],

          )),
    );
  }



  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {

    Future.delayed(Duration.zero, () async{
      bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NoteDetail(note,title);

      }));
    });

    if (result == true) {
      updateListView();
      print("ddd");
    }
  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = 1;
        });
      });
    });
  }
}







