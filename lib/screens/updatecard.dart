
import 'package:flutter/material.dart';
import 'package:ghana/data/database_helper.dart';
import 'package:ghana/data/note.dart';
import 'package:ghana/screens/base_screen.dart';
import 'package:ghana/screens/card_screen.dart';
import 'package:intl/intl.dart';
import 'package:ghana/constants/color_constants.dart';
import 'package:flutter/services.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ghana/screens/agreements.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  NoteDetail(this. note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {

  int _state1 = 0;
  int _state2 = 0;
  int _state3 = 0;
  int _state4 = 0;
  int _state5 = 0;
  static var _priorities = ['High', 'Low'];
  bool isLoading = true;
  getData() async {
    setState(() {
      isLoading = false;
    });

  }

  DatabaseHelper helper = DatabaseHelper();
  final fb = FirebaseDatabase.instance;
  String _bytesImageghcard;
  String _bytesImagesnnit;
  String _bytesImagenhis;
  String _bytesImagelicence;
  String _bytesImagevoterid;
  String _bytesImagepassport;

  bool ishidden=true;
  var retrievedName="";
  var retrievedpassword="";
  var retrievedclass="";
  var dateofbirth="select date of birth";
  var vis ="select date of birth";
  var _base64;

  String appBarTitle;
  Note note;
  int result;


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  String Aghcardsurname;
  String Aghcardfirstname;
  String Aghcardpreviousname;
  String Aghcardnationality;
  String Aghcardsex;
  String Aghcarddateofbirth;
  String Aghcardplaceofissuance;
  String Aghcardid;
  String Aghcardheight;
  String Aghcarddateofissuance;
  String Aghcarddateofexpiry;
  String Aghcarddocumentnumber;

  String Apassportid;

  String Anhisname;
  String Anhissex;
  String Anhisdateofbirth;
  String Anhisid;
  String Anhisdateofissuance;
  String Anhisdateofexpiry;

  String Alicencename;
  String Alicencenationalid;
  String Alicenceprocessingcenter;
  String Alicencenationality;
  String Alicenceclass;
  String Alicencedateofbirth;
  String Adateoffirstlicence;
  String Alicencepin;
  String Alicencedateofissue;
  String Alicencedateofexpiry;
  String Alicencecertificatedate;
  String Acertificateofcompetence;

  String Asnnitname;
  String Asnnitgender;
  String Asnnitdateofbirth;
  String Asnnitid;

  String Avoteridsurname;
  String Avoteridothername;
  String Avoteridsex;
  String Avoteriddateofbirth;
  String Avoteridpollingstationcode;
  String Avoteriddateofregistration;
  String Avoteridnumber;

  String _dob;


  String name = "";




  TextEditingController ghcardid = TextEditingController();
  TextEditingController snnitid = TextEditingController();
  TextEditingController licenceid = TextEditingController();
  TextEditingController nhisid = TextEditingController();
  TextEditingController voteridid = TextEditingController();
  TextEditingController passportid = TextEditingController();


  NoteDetailState(this.note, this.appBarTitle);
  @override
  void initState(){
    super.initState();
    updatePriorityAsInt("High");

  }
  void dispose() {
 /*   ghcardid.dispose();
    nhisid.dispose();
    snnitid.dispose();
    licenceid.dispose();
    voteridid.dispose();*/

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref1=fb.reference().child("nhis");
    final ref2=fb.reference().child("ghcard");
    final ref3=fb.reference().child("licence");
    final ref4=fb.reference().child("votersid");
    final ref5=fb.reference().child("snnit");
    final ref6=fb.reference().child("passport");

   // TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;
    ghcardid.text= note.ghcardid;
    nhisid.text=note.nhisid;
    voteridid.text=note.voteridnumber;
    passportid.text='';
    snnitid.text=note.snnitid;
    licenceid.text=note.licencepin;

    return WillPopScope(

        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Update Information",
              style: TextStyle(
                fontFamily: "Poppins",
                color: kPrimaryColor,
              ),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () =>Navigator.pop(context, true)
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                    size: 27,
                  ),
                  onPressed: () {})
            ],
          ),

          body:  AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.blueGrey,

                    child: Padding(

                      padding: EdgeInsets.only(top: 15.0,),
                      child: ListView(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: SizeConfig.safeBlockVertical * 15,
                              child: Column(
                                children: <Widget>[

                                  Row(children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*92,
                                        child: TextField(
                                          controller: ghcardid,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');
                                            updateghcard();

                                          },
                                          decoration: InputDecoration(
                                              hintText: "Ghana Card ID",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),

                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              )
                                          ),
                                        ),

                                      ),),


                                  ]

                                  ),

                                  Row(
                                    children:  <Widget>[
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*60,


                                        child: OutlineButton(

                                          onPressed: () {

                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(1900, 1, 1),
                                                maxTime: DateTime(2030, 12, 31),
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                    doneStyle:
                                                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18)),
                                                onChanged: (date) {
                                                  print('change $date in time zone ' +
                                                      date.timeZoneOffset.inHours.toString());
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                  ghcarddate(date.month,date.day,date.year);
                                                  setState(() {
                                                    vis = "${date.day}-${date.month}-${date.year}";
                                                  });
                                                }, currentTime: DateTime.now(), locale: LocaleType.en);

                                          },
                                          borderSide: BorderSide(color: Colors.blue),


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),

                                          child:Text(
                                            '$vis',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 1.5,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),

                                        ),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.safeBlockHorizontal*3,
                                      ),
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*30,


                                        child: RaisedButton(
                                          elevation: 5.0,


                                          onPressed:(){
                                            internetcheck1();
                                            animateButton1();

                                            ref2.child("${ghcardid.text}/dateofbirth").once().then((DataSnapshot data2){
                                              setState(() {
                                                debugPrint("Save ID button clicked");
                                                if(data2.value == dateofbirth){

                                                  ref2.child("${ghcardid.text}/id").once().then((DataSnapshot datag1){setState(() {Aghcardid=datag1.value;

                                                  });});
                                                  ref2.child("${ghcardid.text}/surname").once().then((DataSnapshot datag2){setState(() {
                                                    Aghcardsurname=datag2.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/firstname").once().then((DataSnapshot datag3){setState(() {
                                                    Aghcardfirstname=datag3.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/previousname").once().then((DataSnapshot datag4){setState(() {
                                                    Aghcardpreviousname=datag4.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/nationality").once().then((DataSnapshot datag5){setState(() {
                                                    Aghcardnationality=datag5.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/sex").once().then((DataSnapshot datag6){setState(() {
                                                    Aghcardsex=datag6.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/dateofbirth").once().then((DataSnapshot datag7){setState(() {
                                                    Aghcarddateofbirth=datag7.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/placeofissuance").once().then((DataSnapshot datag8){setState(() {
                                                    Aghcardplaceofissuance=datag8.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/height").once().then((DataSnapshot datag9){setState(() {
                                                    Aghcardheight=datag9.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/dateofissuance").once().then((DataSnapshot datag10){setState(() {
                                                    Aghcarddateofissuance=datag10.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/dateofexpiry").once().then((DataSnapshot datag11){setState(() {
                                                    Aghcarddateofexpiry=datag11.value;
                                                  });});
                                                  ref2.child("${ghcardid.text}/documentnumber").once().then((DataSnapshot datag12){setState(() {
                                                    Aghcarddocumentnumber=datag12.value;
                                                  });});
                                                  ghcardimage("${ghcardid.text}");

                                                  print("done SAVING");
                                                }
                                                else{
                                                  wrongid1();

                                                }});});},

                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Color(0XFF203354),
                                          child: setUpButtonChild1(),
                                        ),

                                      ),


                                    ],
                                  ),

                                ],
                              )

                          ),
                          SizedBox(height: SizeConfig.safeBlockVertical*1.5,),
                          //nhis
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: SizeConfig.safeBlockVertical * 15,
                              child: Column(
                                children: <Widget>[

                                  Row(children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*92,
                                        child: TextField(
                                          controller: nhisid,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');
                                            updatenhis();

                                          },
                                          decoration: InputDecoration(
                                              hintText: "NHIS MEMBERSHIP No.",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),

                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              )
                                          ),
                                        ),

                                      ),),


                                  ]

                                  ),

                                  Row(
                                    children:  <Widget>[
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*60,


                                        child: OutlineButton(

                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(1900, 1, 1),
                                                maxTime: DateTime(2030, 12, 31),
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                    doneStyle:
                                                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18)),
                                                onChanged: (date) {
                                                  print('change $date in time zone ' +
                                                      date.timeZoneOffset.inHours.toString());
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                  nhisdate(date.month,date.day,date.year);
                                                  setState(() {
                                                    vis = "${date.day}-${date.month}-${date.year}";
                                                  });
                                                }, currentTime: DateTime.now(), locale: LocaleType.en);

                                          },
                                          borderSide: BorderSide(color: Colors.blue),


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),


                                          child:Text(
                                            '$vis',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 1.5,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),

                                        ),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.safeBlockHorizontal*3,
                                      ),
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*30,


                                        child: RaisedButton(
                                          elevation: 5.0,

                                          onPressed: () {
                                            internetcheck2();
                                            animateButton3();


                                            ref1.child("${nhisid.text}/dateofbirth").once().then((DataSnapshot data2){
                                              setState(() {
                                                debugPrint("Save ID button clicked");

                                                if(data2.value == dateofbirth){

                                                  ref1.child("${nhisid.text}/id").once().then((DataSnapshot datag1){setState(() {
                                                    Anhisid=datag1.value;
                                                  });});
                                                  ref1.child("${nhisid.text}/name").once().then((DataSnapshot datag2){setState(() {
                                                    Anhisname=datag2.value;
                                                  });});
                                                  ref1.child("${nhisid.text}/sex").once().then((DataSnapshot datag6){setState(() {
                                                    Anhissex=datag6.value;
                                                  });});
                                                  ref1.child("${nhisid.text}/dateofbirth").once().then((DataSnapshot datag7){setState(() {
                                                    Anhisdateofbirth=datag7.value;
                                                  });});
                                                  ref1.child("${nhisid.text}/dateofissuance").once().then((DataSnapshot datag10){setState(() {
                                                    Anhisdateofissuance=datag10.value;
                                                  });});
                                                  ref1.child("${nhisid.text}/dateofexpiry").once().then((DataSnapshot datag11){setState(() {
                                                    Anhisdateofexpiry=datag11.value;
                                                  });});
                                                  nhisimage("${nhisid.text}");
                                                }
                                                else{
                                                  wrongid2();

                                                }});});},

                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Color(0XFF203354),
                                          child: setUpButtonChild2(),
                                        ),

                                      ),


                                    ],
                                  ),

                                ],
                              )

                          ),
                          SizedBox(height: SizeConfig.safeBlockVertical*1.5,),

                          //snnit

                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: SizeConfig.safeBlockVertical * 15,
                              child: Column(
                                children: <Widget>[

                                  Row(children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*92,
                                        child: TextField(
                                          controller: snnitid,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');
                                            updatesnnit();

                                          },
                                          decoration: InputDecoration(
                                              hintText: "SNNIT Number",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),

                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              )
                                          ),
                                        ),

                                      ),),


                                  ]

                                  ),

                                  Row(
                                    children:  <Widget>[
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*60,


                                        child: OutlineButton(

                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(1900, 1, 1),
                                                maxTime: DateTime(2030, 12, 31),
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                    doneStyle:
                                                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18)),
                                                onChanged: (date) {
                                                  print('change $date in time zone ' +
                                                      date.timeZoneOffset.inHours.toString());
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                  snnitdate(date.month,date.day,date.year);
                                                  setState(() {
                                                    vis = "${date.day}-${date.month}-${date.year}";
                                                  });
                                                }, currentTime: DateTime.now(), locale: LocaleType.en);

                                          },
                                          borderSide: BorderSide(color: Colors.blue),


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),


                                          child:Text(
                                            '$vis',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 1.5,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.safeBlockHorizontal*3,
                                      ),
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*30,


                                        child: RaisedButton(
                                          elevation: 5.0,

                                          onPressed: () {
                                            internetcheck3();
                                            animateButton5();


                                            ref5.child("${snnitid.text}/dateofbirth").once().then((DataSnapshot data2){
                                              setState(() {
                                                debugPrint("Save ID button clicked");
                                                if(data2.value == dateofbirth){

                                                  ref5.child("${snnitid.text}/id").once().then((DataSnapshot datag1){setState(() {
                                                    Asnnitid=datag1.value; });});
                                                  ref5.child("${snnitid.text}/name").once().then((DataSnapshot datag2){setState(() {
                                                    Asnnitname=datag2.value;
                                                  });});
                                                  ref5.child("${snnitid.text}/gender").once().then((DataSnapshot datag6){setState(() {
                                                    Asnnitgender=datag6.value;
                                                  });});
                                                  ref5.child("${snnitid.text}/dateofbirth").once().then((DataSnapshot datag7){setState(() {
                                                    Asnnitdateofbirth=datag7.value;
                                                  });});
                                                  snnitimage("${snnitid.text}");



                                                }
                                                else{
                                                  wrongid3();

                                                }});});},


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Color(0XFF203354),
                                          child: setUpButtonChild3(),
                                        ),

                                      ),


                                    ],
                                  ),

                                ],
                              )

                          ),
                          SizedBox(height: SizeConfig.safeBlockVertical*1.5,),

                          //licence
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: SizeConfig.safeBlockVertical * 15,
                              child: Column(
                                children: <Widget>[

                                  Row(children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*92,
                                        child: TextField(
                                          controller: licenceid,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');
                                            updatelicence();

                                          },
                                          decoration: InputDecoration(
                                              hintText: "Licence PIN (ID)",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),

                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              )
                                          ),
                                        ),

                                      ),),


                                  ]

                                  ),

                                  Row(
                                    children:  <Widget>[
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*60,


                                        child: OutlineButton(

                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(1900, 1, 1),
                                                maxTime: DateTime(2030, 12, 31),
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                    doneStyle:
                                                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18)),
                                                onChanged: (date) {
                                                  print('change $date in time zone ' +
                                                      date.timeZoneOffset.inHours.toString());
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                  licencedate(date.month,date.day,date.year);
                                                  setState(() {
                                                    vis = "${date.day}-${date.month}-${date.year}";
                                                  });
                                                }, currentTime: DateTime.now(), locale: LocaleType.en);

                                          },
                                          borderSide: BorderSide(color: Colors.blue),


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),

                                          child:Text(
                                            '$vis',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 1.5,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.safeBlockHorizontal*3,
                                      ),
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*30,


                                        child: RaisedButton(
                                          elevation: 5.0,

                                          onPressed: () {
                                            internetcheck4();
                                            animateButton7();


                                            ref3.child("${licenceid.text}/dateofbirth").once().then((DataSnapshot data2){
                                              setState(() {
                                                debugPrint("Save ID button clicked");
                                                if(data2.value == dateofbirth){

                                                  ref3.child("${licenceid.text}/number").once().then((DataSnapshot datag1){setState(() {
                                                    Alicencepin=datag1.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/name").once().then((DataSnapshot datag2){setState(() {
                                                    Alicencename=datag2.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/processingcenter").once().then((DataSnapshot datag3){setState(() {
                                                    Alicenceprocessingcenter=datag3.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/certificatedate").once().then((DataSnapshot datag4){setState(() {
                                                    Alicencecertificatedate=datag4.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/nationality").once().then((DataSnapshot datag5){setState(() {
                                                    Alicencenationality=datag5.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/reference").once().then((DataSnapshot datag6){setState(() {
                                                    Acertificateofcompetence=datag6.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/dateofbirth").once().then((DataSnapshot datag7){setState(() {
                                                    Alicencedateofbirth=datag7.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/class").once().then((DataSnapshot datag8){setState(() {
                                                    Alicenceclass=datag8.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/dateofissue").once().then((DataSnapshot datag10){setState(() {
                                                    Alicencedateofissue=datag10.value;
                                                  });});
                                                  ref3.child("${licenceid.text}/dateofexpiry").once().then((DataSnapshot datag11){setState(() {
                                                    Alicencedateofexpiry=datag11.value;
                                                  });});

                                                  licenceimage("${licenceid.text}");
                                                }
                                                else{
                                                  wrongid4();

                                                }});});},


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Color(0XFF203354),
                                          child: setUpButtonChild4(),
                                        ),

                                      ),


                                    ],
                                  ),

                                ],
                              )

                          ),
                          //votersid
                          SizedBox(height: SizeConfig.safeBlockVertical*1.5,),

                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: SizeConfig.safeBlockVertical * 15,
                              child: Column(
                                children: <Widget>[

                                  Row(children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*92,
                                        child: TextField(
                                          controller: voteridid,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');
                                            updatevoterid();

                                          },
                                          decoration: InputDecoration(
                                              hintText: "Voter Identification Number",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),

                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              )
                                          ),
                                        ),

                                      ),),


                                  ]

                                  ),

                                  Row(
                                    children:  <Widget>[
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*60,


                                        child: OutlineButton(

                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(1900, 1, 1),
                                                maxTime: DateTime(2030, 12, 31),
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                    doneStyle:
                                                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18)),
                                                onChanged: (date) {
                                                  print('change $date in time zone ' +
                                                      date.timeZoneOffset.inHours.toString());
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                  voteriddate(date.month,date.day,date.year);
                                                  setState(() {
                                                    vis = "${date.day}-${date.month}-${date.year}";
                                                  });
                                                }, currentTime: DateTime.now(), locale: LocaleType.en);

                                          },
                                          borderSide: BorderSide(color: Colors.blue),


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),


                                          child:Text(
                                            '$vis',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 1.5,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),

                                        ),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.safeBlockHorizontal*3,
                                      ),
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*30,


                                        child: RaisedButton(
                                          elevation: 5.0,

                                          onPressed: () {
                                            internetcheck5();
                                            animateButton9();


                                            ref4.child("${voteridid.text}/dateofbirth").once().then((DataSnapshot data2){
                                              setState(() {
                                                debugPrint("Save ID button clicked");
                                                if(data2.value == dateofbirth){

                                                  ref4.child("${voteridid.text}/number").once().then((DataSnapshot datag1){setState(() {
                                                    Avoteridnumber=datag1.value;
                                                  });});
                                                  ref4.child("${voteridid.text}/othername").once().then((DataSnapshot datag2){setState(() {
                                                    Avoteridothername=datag2.value;
                                                  });});
                                                  ref4.child("${voteridid.text}/surname").once().then((DataSnapshot datag3){setState(() {
                                                    Avoteridsurname=datag3.value;
                                                  });});
                                                  ref4.child("${voteridid.text}/pollingstationcode").once().then((DataSnapshot datag5){setState(() {
                                                    Avoteridpollingstationcode=datag5.value;
                                                  });});
                                                  ref4.child("${voteridid.text}/dateofbirth").once().then((DataSnapshot datag7){setState(() {
                                                    Avoteriddateofbirth=datag7.value;
                                                  });});
                                                  ref4.child("${voteridid.text}/sex").once().then((DataSnapshot datag8){setState(() {
                                                    Avoteridsex=datag8.value;
                                                  });});
                                                  ref4.child("${voteridid.text}/dateofregistration").once().then((DataSnapshot datag9){setState(() {
                                                    Avoteriddateofregistration=datag9.value;
                                                  });});
                                                  voteridimage("${voteridid.text}");
                                                  
                                                }
                                                else{
                                                  wrongid5();

                                                }});});},


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Color(0XFF203354),
                                          child: setUpButtonChild5(),
                                        ),

                                      ),


                                    ],
                                  ),

                                ],
                              )

                          ),
                          SizedBox(height: SizeConfig.safeBlockVertical*1.5,),
                          //passport

                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: SizeConfig.safeBlockVertical * 15,
                              child: Column(
                                children: <Widget>[

                                  Row(children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*92,
                                        child: TextField(
                                          controller: passportid,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');

                                          },
                                          decoration: InputDecoration(
                                              hintText: "Passport ID",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),

                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              )
                                          ),
                                        ),

                                      ),),


                                  ]

                                  ),

                                  Row(
                                    children:  <Widget>[
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*60,


                                        child: OutlineButton(

                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(1900, 1, 1),
                                                maxTime: DateTime(2030, 12, 31),
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                    doneStyle:
                                                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18)),
                                                onChanged: (date) {
                                                  print('change $date in time zone ' +
                                                      date.timeZoneOffset.inHours.toString());
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                  passportdate(date.month,date.day,date.year);
                                                  setState(() {
                                                    vis = "${date.day}-${date.month}-${date.year}";
                                                  });
                                                }, currentTime: DateTime.now(), locale: LocaleType.en);


                                          },
                                          borderSide: BorderSide(color: Colors.blue),


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),


                                          child:Text(
                                            '$vis',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 1.5,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),


                                        ),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.safeBlockHorizontal*3,
                                      ),
                                      Container(
                                        height: SizeConfig.safeBlockVertical*5,
                                        width: SizeConfig.safeBlockHorizontal*30,


                                        child: RaisedButton(
                                          elevation: 5.0,

                                          onPressed: () {
                                            },


                                          padding: EdgeInsets.all(3.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Color(0XFF203354),
                                          child:Text(
                                            'SAVE ID',
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 1.5,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ),

                                      ),


                                    ],
                                  ),

                                ],
                              )

                          ),






                        ],
                      ),
                    ),






                  ),








                ],
              ),
            ),


          ),

        ));
  }
  void movetocardscreen(){
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => BaseScreen(1)));
    });
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
    print(note.priority);
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];  // 'High'
        break;
      case 2:
        priority = _priorities[1];  // 'Low'
        break;

    }
    return priority;

  }


  // Save data to database
  void _save1() async {
    note.date = DateFormat.yMMMd().format(DateTime.now());
    print(note.id);
    print("almost");
    helper.updateNote(note);
    animateButton2();
    movetocardscreen();// Su
   // moveToLastScreen();//

    if (result != 0) {
      animateButton2();// Success
    } else {  // Failure
      _showAlertDialog('Invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    }
  }
  void _save2() async {
    note.date = DateFormat.yMMMd().format(DateTime.now());
    print(note.id);
    print("almost");
    helper.updateNote(note);
    animateButton4();
    movetocardscreen();// Su
    // moveToLastScreen();//

    if (result != 0) {
      animateButton4();// Success
    } else {  // Failure
      _showAlertDialog('Invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    }
  }
  void _save3() async {
    note.date = DateFormat.yMMMd().format(DateTime.now());
    print(note.id);
    print("almost");
    helper.updateNote(note);
    animateButton6();
    movetocardscreen();// Su
    // moveToLastScreen();//

    if (result != 0) {
      animateButton6();// Success
    } else {  // Failure
      _showAlertDialog('Invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    }
  }
  void _save4() async {
    note.date = DateFormat.yMMMd().format(DateTime.now());
    print(note.id);
    print("almost");
    helper.updateNote(note);
    animateButton8();
    movetocardscreen();// Su
    // moveToLastScreen();//

    if (result != 0) {
      animateButton8();// Success
    } else {  // Failure
      _showAlertDialog('Invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    }
  }
  void _save5() async {
    note.date = DateFormat.yMMMd().format(DateTime.now());
    print(note.id);
    print("almost");
    helper.updateNote(note);
    animateButton10();
    movetocardscreen();// Su
    // moveToLastScreen();//

    if (result != 0) {
      animateButton10();// Success
    } else {  // Failure
      _showAlertDialog('Invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    }
  }

  void _showAlertDialog(String title, String message) {

    var alertStyle = AlertStyle(
      overlayColor: Colors.black87,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.blue,
        ),
      ),
      titleStyle: TextStyle( fontSize: 22,fontWeight: FontWeight.w700,
          color: Colors.red
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.warning,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.blue,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }

  void passportdate(month,day,year){
    print(month);
    print(day);
    print(year);
    dateofbirth="$day-$month-$year";

  }

  void licencedate(month,day,year){
    print(month);
    print(day);
    print(year);
    dateofbirth="$day-$month-$year";

  }
  void ghcarddate(month,day,year){
    print(month);
    print(day);
    print(year);
    dateofbirth="$day-$month-$year";

  }
  void voteriddate(month,day,year){
    print(month);
    print(day);
    print(year);
    dateofbirth="$day-$month-$year";

  }
  void snnitdate(month,day,year){
    print(month);
    print(day);
    print(year);
    dateofbirth="$day-$month-$year";


  }
  void nhisdate(month,day,year){
    print(month);
    print(day);
    print(year);
    dateofbirth="$day-$month-$year";

  }
  void saveghcard(){
    print("all inputs START");
    note.ghcardid = Aghcardid;
    note.ghcardnationality = Aghcardnationality;
    note.ghcardplaceofissuance = Aghcardplaceofissuance ;
    note.ghcarddateofexpiry = Aghcarddateofexpiry;
    note.ghcarddocumentnumber = Aghcarddocumentnumber;
    note.ghcardheight = Aghcardheight;
    note.ghcarddateofbirth = Aghcarddateofbirth;
    note.ghcardsex = Aghcardsex;
    note.ghcardpreviousname = Aghcardpreviousname;
    note.ghcardfirstname = Aghcardfirstname;
    note.ghcardsurname = Aghcardsurname;
    note.ghcarddateofissuance = Aghcarddateofissuance;
    print("all inputs done");
    _save1();


  }



  void wrongid1(){
    _showAlertDialog('invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    animateButton2();
  }
  void wrongid2(){
    _showAlertDialog('invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    animateButton4();
  }
  void wrongid3(){
    _showAlertDialog('invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    animateButton6();
  }
  void wrongid4(){
    _showAlertDialog('invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    animateButton8();
  }
  void wrongid5(){
    _showAlertDialog('invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    animateButton10();
  }
  void savenhis(){
    note.nhisid = Anhisid;
    note.nhisdateofexpiry = Anhisdateofexpiry;
    note.nhisdateofbirth = Anhisdateofbirth;
    note.nhissex = Anhissex;
    note.nhisname = Anhisname;
    note.nhisdateofissuance = Anhisdateofissuance;
    _save2();

  }
  void savelicence(){
    note.licencepin = Alicencepin;
    note.licencenationality = Alicencenationality;
    note.licencedateofexpiry = Alicencedateofexpiry;
    note.licenceclass = Alicenceclass;
    note.licencedateofbirth = Alicencedateofbirth;
    note.licencecertificatedate = Alicencecertificatedate;
    note.certificateofcompetence = Acertificateofcompetence;
    note.licencename = Alicencename;
    note.licenceprocessingcenter = Alicenceprocessingcenter;
    note.licencedateofissue = Alicencedateofissue;
    _save4();

  }
  void savesnnit(){

    note.snnitid = Asnnitid;
    note.snnitdateofbirth = Asnnitdateofbirth;
    note.snnitgender = Asnnitgender;
    note.snnitname = Asnnitname;
    _save3();



  }
  void savevoterid(){
    note.voteridnumber = Avoteridnumber;
    note.voteridpollingstationcode = Avoteridpollingstationcode;
    note.voteriddateofbirth = Avoteriddateofbirth;
    note.voteridsex = Avoteridsex;
    note.voteridothername = Avoteridothername;
    note.voteridsurname = Avoteridsurname;
    note.voteriddateofregistration= Avoteriddateofregistration;
    _save5();

  }


  void updateghcard(){
    note.ghcardid = ghcardid.text;
  }
  void updatenhis(){
    note.nhisid = nhisid.text;
  }
  void updatesnnit(){
    note.snnitid = snnitid.text;
  }
  void updatevoterid(){
    note.voteridnumber = voteridid.text;
  }
  void updatelicence(){
    note.licencepin = licenceid.text;
  }

  void ghcardimage(data) async{
    http.Response response = await http.get(
      Uri.parse('https://firebasestorage.googleapis.com/v0/b/ghana-66a63.appspot.com/o/ghcard%2F$data.jpeg?alt=media'),
    );
    _bytesImageghcard = base64Encode(response.bodyBytes);
    note.ghcardpicture= _bytesImageghcard;
    print("${note.ghcardpicture}");
    saveghcard();

  }
  void snnitimage(data) async{
    http.Response response = await http.get(
      Uri.parse('https://firebasestorage.googleapis.com/v0/b/ghana-66a63.appspot.com/o/snnit%2F$data.jpeg?alt=media'),
    );
    _bytesImagesnnit = base64Encode(response.bodyBytes);
    note.snnitpicture= _bytesImagesnnit;
    print("${note.snnitpicture}");
    savesnnit();

  }
  void voteridimage(data) async{
    http.Response response = await http.get(
      Uri.parse('https://firebasestorage.googleapis.com/v0/b/ghana-66a63.appspot.com/o/voterid%2F$data.jpeg?alt=media'),
    );
    _bytesImagevoterid = base64Encode(response.bodyBytes);
    note.voteridpicture= _bytesImagevoterid;
    print("${note.voteridpicture}");
    savevoterid();

  }
  void licenceimage(data) async{
    http.Response response = await http.get(
      Uri.parse('https://firebasestorage.googleapis.com/v0/b/ghana-66a63.appspot.com/o/licence%2F$data.jpeg?alt=media'),
    );
    _bytesImagelicence = base64Encode(response.bodyBytes);
    note.licencepicture= _bytesImagelicence;
    print("${note.licencepicture}");
    savelicence();

  }
  void nhisimage(data) async{
    http.Response response = await http.get(
      Uri.parse('https://firebasestorage.googleapis.com/v0/b/ghana-66a63.appspot.com/o/nhis%2F$data.jpeg?alt=media'),
    );
    _bytesImagenhis = base64Encode(response.bodyBytes);
    note.nhispicture= _bytesImagenhis;
    print("${note.nhispicture}");
    savenhis();

  }


  void internetcheck1()async{
    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");
      animateButton2();

    }
  }
  void internetcheck2()async{
    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");
      animateButton4();

    }
  }
  void internetcheck3()async{
    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");
      animateButton6();

    }
  }
  void internetcheck4()async{
    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");
      animateButton8();

    }
  }
  void internetcheck5()async{
    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");
      animateButton10();

    }
  }
  void animateButton2() {
    setState(() {
      _state1 = 0;
    });
  }
  void animateButton1() {
    setState(() {
      _state1 = 1;
    });
  }
  void animateButton4() {
    setState(() {
      _state2 = 0;
    });
  }
  void animateButton3() {
    setState(() {
      _state2 = 1;
    });
  }
  void animateButton6() {
    setState(() {
      _state3 = 0;
    });
  }
  void animateButton5() {
    setState(() {
      _state3 = 1;
    });
  }
  void animateButton8() {
    setState(() {
      _state4 = 0;
    });
  }
  void animateButton7() {
    setState(() {
      _state4 = 1;
    });
  }
  void animateButton10() {
    setState(() {
      _state5 = 0;
    });
  }
  void animateButton9() {
    setState(() {
      _state5 = 1;
    });
  }

  Widget setUpButtonChild5() {
    if (_state5 == 0) {
      return new Text(
        'SAVE ID',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      );
    } else if (_state5 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget setUpButtonChild1() {
    if (_state1 == 0) {
      return new Text(
        'SAVE ID',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      );
    } else if (_state1 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget setUpButtonChild2() {
    if (_state2 == 0) {
      return new Text(
        'SAVE ID',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      );
    } else if (_state2 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget setUpButtonChild3() {
    if (_state3 == 0) {
      return new Text(
        'SAVE ID',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      );
    } else if (_state3 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget setUpButtonChild4() {
    if (_state4 == 0) {
      return new Text(
        'SAVE ID',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      );
    } else if (_state4 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }






}










