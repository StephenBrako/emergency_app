import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ghana/data/database_helper.dart';
import 'package:ghana/data/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geolocator/geolocator.dart';



class HomeScreen extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  HomeScreen(this. note, this.appBarTitle,{Key key}): super(key: key);
  @override
  State<StatefulWidget> createState() {

    return _HomeScreenState(this.note, this.appBarTitle);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Note note;
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  final fb = FirebaseDatabase.instance;
  String datetime;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  var cod=" ";

  
  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    //helper.insertNote(note);
   // navigateToDetail(this.noteList[0],'Edit Note');
  }
  _HomeScreenState(this.note, this.appBarTitle);

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        cod = "$_currentPosition";
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }



  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    final refa=fb.reference().child("ghcard/${noteList[0].ghcardid}/tracker");

    SizeConfig().init(context);
    
    return Scaffold(

      body: Container(
          height: SizeConfig.safeBlockVertical*100,
          width: SizeConfig.safeBlockHorizontal*100,

        decoration: BoxDecoration(
          color: Colors.greenAccent,
          image: DecorationImage(
            image: AssetImage("assets/nkrumah2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(7),
          color: Colors.black.withOpacity(0.5),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical*10,
              ),
            Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                width: SizeConfig.safeBlockHorizontal*10,

                height: SizeConfig.safeBlockVertical*5,
                child: Image.asset('assets/coatofarms.png'),
              ),

                 Text("REPUBLIC OF GHANA",
                style: TextStyle(fontSize: 28,color:Colors.white,fontWeight: FontWeight.w900),
              ),
              Container(
                width: SizeConfig.safeBlockHorizontal*10,

                height: SizeConfig.safeBlockVertical*5,
                child: Image.asset('assets/flag.png'),
              ),
            ]),
              SizedBox(
                height: SizeConfig.safeBlockVertical*3,
              ),
             GestureDetector(
               onTap: _getCurrentLocation,
               child: Container(
                   width: SizeConfig.safeBlockHorizontal*100,
                   height: SizeConfig.safeBlockVertical*5,
                   color: Colors.black.withOpacity(0.4),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       /* Text("location: ",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.amber),),*/
                       if (_currentPosition != null &&
                           _currentAddress != null)
                         Text("$cod",
                           style: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.w600),
                         ),
                     ],
                   )
               ),
             ) ,

              SizedBox(
                height: SizeConfig.safeBlockVertical*32,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal*2,
                  ),
                 GestureDetector(
                   onTap:(){

                     var alertStyle = AlertStyle(
                       overlayColor: Colors.black87,
                       animationType: AnimationType.fromTop,
                       isCloseButton: true,
                       isOverlayTapDismiss: true,
                       descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                       animationDuration: Duration(milliseconds: 100),
                       alertBorder: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30.0),
                         side: BorderSide(
                           color: Colors.grey,
                         ),
                       ),
                       titleStyle: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w800),
                     );
                     Alert(
                       context: context,
                       style: alertStyle,
                       type: AlertType.warning,
                       title: "For Emergencies Only",
                       desc: "This will send your current location to Ghana Police Service immediately. False alarms will attract fines against your profile",
                       buttons: [
                         DialogButton(


                           child: Text(
                             "Ongoing Robbery",
                             style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                           ),
                           onPressed: () => _ongoing_robbery(),

                           color: Color.fromRGBO(91, 55, 185, 1.0),
                           radius: BorderRadius.circular(7.0),
                         ),
                         DialogButton(
                           child: Text(
                             "Report Accident",
                             style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w800),
                           ),
                           onPressed: () => _accident(),

                           color: Color.fromRGBO(91, 55, 185, 1.0),
                           radius: BorderRadius.circular(7.0),
                         ),
                       ],
                     ).show();
                   },
                   child: Container(
                     padding: EdgeInsets.all(10),
                     height: SizeConfig.safeBlockVertical*15,
                     width: SizeConfig.safeBlockHorizontal*44,
                     decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.9),
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Text(
                                   "POLICE SERVICE",
                                   style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.w700),
                                 ),
                                 Container(

                                   width: SizeConfig.safeBlockHorizontal*15,
                                   height: SizeConfig.safeBlockVertical*7.4,
                                   child: Image.asset('assets/police.jpg'),
                                 ),

                               ],
                             ),


                           ],
                         ),

                       ],
                     ),/* add child content here */
                   ),
                 ) ,
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal*4,
                  ),
                  GestureDetector(

                    onTap:(){
                      var alertStyle = AlertStyle(
                        overlayColor: Colors.black87,
                        animationType: AnimationType.fromTop,
                        isCloseButton: true,
                        isOverlayTapDismiss: true,
                        descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                        animationDuration: Duration(milliseconds: 100),
                        alertBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        titleStyle: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w800),
                      );
                      Alert(
                        context: context,
                        style: alertStyle,
                        type: AlertType.warning,
                        title: "For Emergencies Only",
                        desc: "This will send your current location to Ghana Fire Service immediately. False alarms will attract fines against your profile",
                        buttons: [
                          DialogButton(

                            child: Text(
                              "Ongoing Fire",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                            onPressed: () => _ongoing_fire(),

                            color: Color.fromRGBO(91, 55, 185, 1.0),
                            radius: BorderRadius.circular(7.0),
                          ),
                          DialogButton(
                            child: Text(
                              "Accident",
                              style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w800),
                            ),
                            onPressed: () => _accident(),

                            color: Color.fromRGBO(91, 55, 185, 1.0),
                            radius: BorderRadius.circular(7.0),
                          ),
                        ],
                      ).show();
                    },
                    child:  Container(
                    padding: EdgeInsets.all(10),
                    height: SizeConfig.safeBlockVertical*15,
                    width: SizeConfig.safeBlockHorizontal*44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "FIRE SERVICE",
                                  style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.w700),
                                ),
                                Container(

                                  width: SizeConfig.safeBlockHorizontal*30,
                                  height: SizeConfig.safeBlockVertical*9.5,
                                  child: Image.asset('assets/fireservice.png'),
                                ),

                              ],
                            ),

                          ],
                        ),

                      ],
                    ),/* add child content here */
                  ),),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal*1,
                  ),

                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical*2,
              ),


              GestureDetector(
                onTap:(){
                  var alertStyle = AlertStyle(
                    overlayColor: Colors.black87,
                    animationType: AnimationType.fromTop,
                    isCloseButton: true,
                    isOverlayTapDismiss: true,
                    descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                    animationDuration: Duration(milliseconds: 100),
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    titleStyle: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w800),
                  );
                  Alert(
                    context: context,
                    style: alertStyle,
                    type: AlertType.warning,
                    title: "For Emergencies Only",
                    desc: "This will send your current location to the nearest ambulance immediately. False alarms will attract fines against your profile",
                    buttons: [
                      DialogButton(


                        child: Text(
                          "Request Ambulance",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        onPressed: () => _ambulance(),

                        color: Color.fromRGBO(91, 55, 185, 1.0),
                        radius: BorderRadius.circular(7.0),
                      ),

                    ],
                  ).show();
                },
                child: Container(
                padding: EdgeInsets.all(10),
                height: SizeConfig.safeBlockVertical*10,
                width: SizeConfig.safeBlockHorizontal*92,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "AMBULANCE SERVICE",
                              style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.w700),
                            ),
                            Container(

                              width: SizeConfig.safeBlockHorizontal*35,
                              height: SizeConfig.safeBlockVertical*6.5,
                              child: Image.asset('assets/ambulance.png'),
                            ),


                          ],
                        ),

                      ],
                    ),

                  ],
                ),/* add child content here */
              ),),
              SizedBox(
                height: SizeConfig.safeBlockVertical*1,
              ),
              Container(
                  width: SizeConfig.safeBlockHorizontal*100,
                  height: SizeConfig.safeBlockVertical*5,
                  color: Colors.black.withOpacity(0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("EMERGENCY PURPOSES ONLY",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.amber),),
                      Text("!!!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.red),),

                    ],
                  )
              ),

              //stream for categorypage


            ],
          ),
          
        ),
        ),

    );
  }
  void _accident()async{
    _getCurrentLocation();
    bool results = await DataConnectionChecker().hasConnection;
    if(results == true) {
    DateTime date = DateTime.now();
    final setlong=fb.reference().child("accidents/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/long");
    setlong.set('${_currentPosition.longitude}');
    final setlat=fb.reference().child("accidents/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/lat");
    setlat.set('${_currentPosition.latitude}');
    final setid=fb.reference().child("accidents/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/id");
    setid.set('${noteList[0].ghcardid}');
    final setredflag=fb.reference().child("accidents/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/red flag");
    setredflag.set('true');
    final settime=fb.reference().child("accidents/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/date and time");
    settime.set('${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}');
   /* FirebaseFirestore.instance.collection("active").doc('${noteList[0].ghcardid}').set({
      "id": "${noteList[0].ghcardid}",
      "latitude": "${_currentPosition.latitude}",
      "longitude": "${_currentPosition.longitude}",
      "dateandtime": "${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}"

    });*/
    Navigator.of(context).pop();
    locationsent("Help is one the way! Kindly wait and be safe!");}else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");


    }



  }

  void _ambulance()async{
    _getCurrentLocation();
    bool results = await DataConnectionChecker().hasConnection;
    if(results == true) {
    DateTime date = DateTime.now();
    final setlong=fb.reference().child("ambulance/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/long");
    setlong.set('${_currentPosition.longitude}');
    final setlat=fb.reference().child("ambulance/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/lat");
    setlat.set('${_currentPosition.latitude}');
    final setid=fb.reference().child("ambulance/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/id");
    setid.set('${noteList[0].ghcardid}');
    final setredflag=fb.reference().child("ambulance/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/red flag");
    setredflag.set('true');
    final settime=fb.reference().child("ambulance/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/date and time");
    settime.set('${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}');
    Navigator.of(context).pop();
    locationsent("Help is one the way! Kindly wait for the ambulance. Be safe!");}else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");


    }


  }

  void _ongoing_robbery()async{
    _getCurrentLocation();
    bool results = await DataConnectionChecker().hasConnection;
    if(results == true) {
    DateTime date = DateTime.now();
    final setlong=fb.reference().child("robbery/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/long");
    setlong.set('${_currentPosition.longitude}');
    final setlat=fb.reference().child("robbery/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/lat");
    setlat.set('${_currentPosition.latitude}');
    final setid=fb.reference().child("robbery/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/id");
    setid.set('${noteList[0].ghcardid}');
    final setredflag=fb.reference().child("robbery/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/red flag");
    setredflag.set('true');
    final settime=fb.reference().child("robbery/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/date and time");
    settime.set('${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}');
    /*FirebaseFirestore.instance.collection("active").doc('${noteList[0].ghcardid}').set({
      "id": "${noteList[0].ghcardid}",
      "latitude": "${_currentPosition.latitude}",
      "longitude": "${_currentPosition.longitude}",
      "dateandtime": "${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}"

    });*/
    Navigator.of(context).pop();
    locationsent("Help is one the way! Kindly wait for the police. Be safe!");}else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");


    }

  }

  void _ongoing_fire()async{
    _getCurrentLocation();
    bool results = await DataConnectionChecker().hasConnection;
    if(results == true) {
    DateTime date = DateTime.now();
    final setlong=fb.reference().child("fire/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/long");
    setlong.set('${_currentPosition.longitude}');
    final setlat=fb.reference().child("fire/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/lat");
    setlat.set('${_currentPosition.latitude}');
    final setid=fb.reference().child("fire/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/id");
    setid.set('${noteList[0].ghcardid}');
    final setredflag=fb.reference().child("fire/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/red flag");
    setredflag.set('true');
    final settime=fb.reference().child("fire/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/date and time");
    settime.set('${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}');
    /*FirebaseFirestore.instance.collection("active").doc('${noteList[0].ghcardid}').set({
      "id": "${noteList[0].ghcardid}",
      "latitude": "${_currentPosition.latitude}",
      "longitude": "${_currentPosition.longitude}",
      "dateandtime": "${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}"

    });*/
    Navigator.of(context).pop();
    locationsent("Help is one the way! Kindly wait for the fire service. Be safe!");} else {
      _showAlertDialog('no internet connection', "check your WiFi or mobbile network data connection");


    }



  }


  void locationsent(data){
    _showAlertDialog2('Location sent!', data);

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
  void _showAlertDialog2(String title, String message) {

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
          color: Colors.blue
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Understood",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.blue,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
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

  void sendloc(data3){
    _getCurrentLocation();
    if(data3=="true"){
      DateTime date = DateTime.now();
      final setlong=fb.reference().child("tracker/${noteList[0].ghcardid}/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/long");
      setlong.set('${_currentPosition.longitude}');
      final setlat=fb.reference().child("tracker/${noteList[0].ghcardid}/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/lat");
      setlat.set('${_currentPosition.latitude}');
      final setgps=fb.reference().child("tracker/${noteList[0].ghcardid}/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/gps");
      setgps.set('${_currentPosition.latitude},${_currentPosition.longitude}');
      final settime=fb.reference().child("tracker/${noteList[0].ghcardid}/${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}/date and time");
      settime.set('${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}');
      final offred=fb.reference().child("ghcard/${noteList[0].ghcardid}/tracker");
      offred.set('false');


    }else{
      print("location not sent");
    }

  }

}
