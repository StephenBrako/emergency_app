import 'package:flutter/material.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:ghana/constants/color_constants.dart';
import 'package:ghana/screens/manual1.dart';
import 'package:shared_preferences/shared_preferences.dart';
class agreement extends StatefulWidget {
  @override
  _agreementState createState() => _agreementState();
}

class _agreementState extends State<agreement> {

  bool agree = false;

  // This function is triggered when the button is clicked
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Terms and Conditions",//voters id, passport, license,snnit
          style: TextStyle(
            fontFamily: "Poppins",
            color: kPrimaryColor,
          ),
        ),


      ),

      body:  Column(children: [
       Expanded(
         child: Container(
             padding: EdgeInsets.only(left: 15,right: 15),
             height: SizeConfig.safeBlockVertical*80,
             child:
             SingleChildScrollView(
           child: Text(
             'This Terms and Conditions Agreement ("Agreement") is a legal document that explains your rights and obligations as a user of the service of the Company.\n\n By accessing or using any website with an authorised link to the website and/or the app, registering an account or accessing or using any content, clicking on a button or taking another action to signify acceptance of the Agreement, the user agrees to be bound by this Agreement and any future amendments and additions to this Agreement as published through the Services; represents that you are of legal age in your jurisdiction of residence to form a binding contract; and represents that you have the authority to enter into this Agreement personally and, if applicable, on behalf of any company, organisation, or other legal entity on whose behalf you use the Services.\n \nThis Terms and Conditions Agreement ("Agreement") is a legal document that explains your rights and obligations as a user of the service of the Company. '
                 '\n\nBy accessing or using any website with an authorised link to the website and/or the app, registering an account or accessing or using any content, clicking on a button or taking another action to signify acceptance of the Agreement, the user agrees to be bound by this Agreement and any future amendments and additions to this Agreement as published through the Services; represents that you are of legal age in your jurisdiction of residence to form a binding contract; and represents that you have the authority to enter into this Agreement personally and, if applicable, on behalf of any company, organisation, or other legal entity on whose behalf you use the Services. This Terms and Conditions Agreement ("Agreement") is a legal document that explains your rights and obligations as a user of the service of the Company.\n \nBy accessing or using any website with an authorised link to the website and/or the app, registering an account or accessing or using any content, clicking on a button or taking another action to signify acceptance of the Agreement, the user agrees to be bound by this Agreement and any future amendments and additions to this Agreement as published through the Services; represents that you are of legal age in your jurisdiction of residence to form a binding contract; and represents that you have the authority to enter into this Agreement personally and, if applicable, on behalf of any company, organisation, or other legal entity on whose behalf you use the Services. This Terms and Conditions Agreement ("Agreement") is a legal document that explains your rights and obligations as a user of the service of the Company. '
                 '\n\nBy accessing or using any website with an authorised link to the website and/or the app, registering an account or accessing or using any content, clicking on a button or taking another action to signify acceptance of the Agreement, the user agrees to be bound by this Agreement and any future amendments and additions to this Agreement as published through the Services; represents that you are of legal age in your jurisdiction of residence to form a binding contract; and represents that you have the authority to enter into this Agreement personally and, if applicable, on behalf of any company, organisation, or other legal entity on whose behalf you use the Services.',
             overflow: TextOverflow.clip, textAlign: TextAlign.justify,
           ),
         )) ,
       ) ,
        Row(
          children: [
            Material(
              child: Checkbox(
                value: agree,
                onChanged: (value) {
                  setState(() {
                    agree = value;
                  });
                },
              ),
            ),
            Text(
              'I have read and accept terms and conditions',
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        ElevatedButton(onPressed: agree ? movetomanual : null, child: Text('Continue')),
        SizedBox(
          height: SizeConfig.safeBlockVertical*2,
        )
      ]),
    );
  }
  void movetomanual() {
    setState(() {
      _signupdone();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => manual1()));
    });
  }
  void _signupdone() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = 50;
    prefs.setInt(key, value);
    print('saved $value');
  }
}
