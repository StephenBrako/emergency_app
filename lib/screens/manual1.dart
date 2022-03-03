import 'package:flutter/material.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:ghana/constants/color_constants.dart';
import 'package:ghana/screens/base_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class manual1 extends StatefulWidget {
  @override
  _manual1State createState() => _manual1State();
}

class _manual1State extends State<manual1> {

  bool agree = false;
  final List<String> imageList = [
    "assets/manual3.png",
    "assets/manual2.png",
    "assets/manual1.png"
      ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Guide",//voters id, passport, license,snnit
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.amber,
          ),
        ),


      ),

      body:  Column(children: [

        Container(
          padding: EdgeInsets.only(left: 15,right: 15,bottom: SizeConfig.safeBlockVertical*4),
          height: SizeConfig.safeBlockVertical*87,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              height: SizeConfig.safeBlockVertical*100,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlay: true,

            ),
            items: imageList.map((e) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(e,
                    fit: BoxFit.cover,
                  ),

                ],
              ) ,
            )).toList(),
          ),
        ),



        Row(mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ElevatedButton(onPressed: movetomain, child: Text('Done',style: TextStyle( fontSize:18))),
            SizedBox(
              width: SizeConfig.safeBlockHorizontal*5,
            )
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical*3,
        )
      ]),

    );
  }
  void movetomain() {
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => BaseScreen(0)));
    });
  }

 
}
