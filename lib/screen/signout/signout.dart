import 'package:budgetgo/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';


import '../../Widget/bezierContainer.dart';
import '../home_page/home_page.dart';

class LogoutPage extends StatefulWidget {
  final toggleBrightness;

  LogoutPage(
      {Key key, this.title = 'User Settings', @required this.toggleBrightness})
      : super(key: key);

  final String title;

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  
  
  
  Widget _submitButton() {
    return InkWell(
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(toggleBrightness: widget.toggleBrightness)));
        
         
      },
      // onTap: () {
      //    Navigator.push(
      //        context, MaterialPageRoute(builder: (context) => LoginPage()));
      // },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xfffbb448).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Color(0xfffbb448)),
        child: Text(
          'Proceed to Login Screen',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Budget',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        TextSpan(
          text: 'Go',
          style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
        ),
      ]),
    );
  }

  Widget _text() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'You are now logget out.\n\n\n',
          style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: 'Thank you for using BudgetGO mobile application. Hope you enjoyed your trip.',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ]),
    );
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 125,
                ),
                _title(),
                SizedBox(
                  height: 90,
                ),
                _text(),
                SizedBox(
                  height: 100,
                ),
                _submitButton(),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
           Positioned(
               top: -MediaQuery.of(context).size.height * .15,
               right: -MediaQuery.of(context).size.width * .4,
               child: BezierContainer())
        ],
      ),
    )));
  }
}
