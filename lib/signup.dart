import 'package:flutter/material.dart';
import 'package:ghana/screens/agreements.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:ghana/data/database_helper.dart';
import 'package:ghana/data/note.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
class signup extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  signup(this. note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return signupState(this.note, this.appBarTitle);
  }
}

class signupState extends State<signup> {
  int _state = 0;
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
  var dateofbirth="select date of birth";
  var vis ="select date of birth";
  String appBarTitle;
  Note note;
  int result;
  TextEditingController titleController = TextEditingController();
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
  TextEditingController ghcardid = TextEditingController();
  signupState(this.note, this.appBarTitle);
  @override
  void initState(){
    super.initState();
    note.title="rr";

    updatePriorityAsInt("High");
    note.snnitpicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";

    note.voteridpicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";

    note.licencepicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";

    note.nhispicture =
    "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAF8AZ8DASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAcIBQYBAgQD/8QARxABAAEDAwEDBggMBAUFAAAAAAIDBAUBBhIHERMiCCExMkJSFBUjQVFicXIkNkNGYXWBgoSRssMzU6KxJTRjc6EWRJLB4f/EABYBAQEBAAAAAAAAAAAAAAAAAAACAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwC5YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBuLdmCwFKU8hfQhLT2I+eQM++U6kKUOVScIR+mXmQtuLrPXqaTpYKy0p8fRVreJH+Y3ZuLLVZSvcrXlCXrU4z40wWPyu7tu47T8KytDTX6Iy5f7Ndu+re0aPmo3NavL6Iw7P8AdXf3pe960nIJ8n1j277FGvJ2pdYdsSnxqxuKcfe4dqAQFmsV1F2jkp93b5WEZf8AUjxbNa3lrdw521zRrR+mnPSSnk/EyOKzGWxc4zx9/XtuM+XGM5RjIFuhBm0+sN5RlGhn7anWh/m0/NKMf0pdwGdxedtI3OMuYVqcvm+eP7AZYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABitxZzG4GwlfZK5hRpx083b6ZfY+e7M9Y7cw9XIX09IxjHwR+eUvoVl3VuTJbmyUr2/nOUecu6";
   // helper.insertNote(note);


  }

  @override
  Widget build(BuildContext context) {
    final ref2=fb.reference().child("ghcard");
    return Scaffold(
      body: Container(
        height: double.infinity,

        decoration: BoxDecoration(
          color: Colors.greenAccent,
          image: DecorationImage(
            image: AssetImage("assets/nkrumah2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            height: SizeConfig.safeBlockVertical*100,
            width: SizeConfig.safeBlockHorizontal*100,
            color: Colors.black.withOpacity(0.85),
            child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical*10,
                  ),
                  Row(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal*2,
                        ),
                        Container(

                          width: SizeConfig.safeBlockHorizontal*10,

                          height: SizeConfig.safeBlockVertical*5,
                          child: Image.asset('assets/flag.png'),
                        ),

                        Text("REPUBLIC OF GHANA",
                          style: TextStyle(fontSize: 28,color:Colors.white,fontWeight: FontWeight.w900),
                        ),
                        Container(
                          width: SizeConfig.safeBlockHorizontal*10,

                          height: SizeConfig.safeBlockVertical*5,
                          child: Image.asset('assets/flag.png'),


                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal*2,
                        ),
                      ]),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical*2,
                  ),

                      Container(
                        width: SizeConfig.safeBlockHorizontal*50,

                        height: SizeConfig.safeBlockVertical*20,
                        child: Image.asset('assets/coatofarms.png'),),

                  SizedBox(
                    height: SizeConfig.safeBlockVertical*6,
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),

                      ),

                      child: Column(
                        children: <Widget>[

                          Row(children: <Widget>[
                            Padding(padding: EdgeInsets.only(top:SizeConfig.safeBlockVertical*1, right:SizeConfig.safeBlockHorizontal*2,left: SizeConfig.safeBlockHorizontal*2, bottom:SizeConfig.safeBlockVertical*1),
                              child:Container(

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                                  ,color: Colors.white

                                ),

                                height: SizeConfig.safeBlockVertical*7,
                                width: SizeConfig.safeBlockHorizontal*90,
                                child: TextField(
                                  controller: ghcardid,
                                  style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
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
                          SizedBox(
                            height: SizeConfig.safeBlockVertical*2,
                          ),

                          Row(
                            children:  <Widget>[
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal*2,
                              ),
                              Container(

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                    ,color: Colors.white

                                ),

                                height: SizeConfig.safeBlockVertical*6.5,
                                width: SizeConfig.safeBlockHorizontal*55,


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
                                    borderRadius: BorderRadius.circular(15.0),
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
                                height: SizeConfig.safeBlockVertical*6.5,
                                width: SizeConfig.safeBlockHorizontal*30,


                                child: RaisedButton(
                                  elevation: 5.0,


                                  onPressed:(){
                                    internetcheck();
                                    animateButton();

                                    ref2.child("${ghcardid.text}/dateofbirth").once().then((DataSnapshot data2){
                                      setState(() {
                                       // helper.insertNote(note);
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
                                          wrongid();

                                        }});});},

                                  padding: EdgeInsets.all(3.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: Color(0XFF0043AE),
                                  child: setUpButtonChild(),
                                ),

                              ),


                            ],
                          ),

                        ],
                      )

                  ),
                    

                ])
        ),
      ),
    );
  }


  void movetoagreement() {
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => agreement()));
    }); }

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

  // Update the title of Note object
  void updateTitle(){
    note.title = titleController.text;
  }

  // Save data to database
  void _save() async {
    note.date = DateFormat.yMMMd().format(DateTime.now());
    print(note.id);
    print("almost");
    helper.insertNote(note);


    animateButton2();// Success
    movetoagreement();

    if (result != 0) {
      animateButton2();// Success
      movetoagreement();
    } else {  // Failure
      _showAlertDialog('invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
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
    note.ghcardheight = Aghcardheight;
    note.ghcarddateofbirth = Aghcarddateofbirth;
    note.ghcardsex = Aghcardsex;
    note.ghcardpreviousname = Aghcardpreviousname;
    note.ghcardfirstname = Aghcardfirstname;
    note.ghcardsurname = Aghcardsurname;
    note.ghcarddateofissuance = Aghcarddateofissuance;
    note.ghcarddocumentnumber = Aghcarddocumentnumber;
    print("all inputs done");
    _save();


  }



  void wrongid(){
    _showAlertDialog('Invalid ID or date of birth', "Kindly enter a valid ECOWAS Card( Ghana Card) ID and correct date of birth");
    animateButton2();
  }

  void updateghcard(){
    note.ghcardid = ghcardid.text;
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


  void internetcheck()async{
    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");
      animateButton2();

    }
  }
  void animateButton2() {
    setState(() {
      _state = 0;
    });
  }
  void animateButton() {
    setState(() {
      _state = 1;
    });
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
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
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }




}
