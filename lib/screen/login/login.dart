import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

// import 'package:flutter_ui_splash_screen/homeScreen.dart';
// import 'signup.dart';
//import 'package:google_fonts/google_fonts.dart';

import '../../widget/bezier_container.dart';
import '../home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  final toggleBrightness;

  LoginPage(
      {Key key, this.title = 'User Settings', @required this.toggleBrightness})
      : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _validateUsername = false;
  bool _validatePassword = false;
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget _passwordEntryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _password,
              style:
                  new TextStyle(color: Colors.black, height: 1.0, fontSize: 18),
              obscureText: true,
              decoration: InputDecoration(
                  errorText: _validatePassword
                      ? 'The password field cannot be empty'
                      : null,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0)))
        ],
      ),
    );
  }

  Widget _usernameEntryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _username,
              style:
                  new TextStyle(color: Colors.black, height: 1.0, fontSize: 18),
              decoration: InputDecoration(
                  errorText: _validateUsername
                      ? 'The username field cannot be empty'
                      : null,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0)))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _password.text.isEmpty
              ? _validatePassword = true
              : _validatePassword = false;
          _username.text.isEmpty
              ? _validateUsername = true
              : _validateUsername = false;
        });
        bool _validateMatched = false;
        List<User> check = [];
        if (_validatePassword == false && _validateUsername == false) {
          check.addAll(loginData.where((a) => a.username == _username.text));
          print(check.length.toString() + "username");
          if (check.length == 1) {
            if (check[0].password == _password.text) {
              _validateMatched = true;
            }
          }

          if (_validateMatched == true) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(toggleBrightness: widget.toggleBrightness)),
                (_) => false);
          } else {
            check.clear();
            _loginErrorAlert(context);
          }
        }
      },
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
          'Login',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _googleFacebookLogin() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // color: Colors.blue,
            height: 20,
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: FacebookSignInButton(
              text: 'Facebook',
              onPressed: null,
              textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            // color: Colors.blue,
            height: 100,
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: GoogleSignInButton(
              onPressed: null,
              text: 'Google',
              textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            height: 20,
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      "BudgetGo",
      style: TextStyle(fontSize: 30),
    );
  }

  Widget _usernamePasswordWidget() {
    return Column(
      children: <Widget>[
        _usernameEntryField("Username"),
        _passwordEntryField("Password"),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or sign in with'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Future<void> _loginErrorAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: const Text(
              'The username and password are not matched. Please try again'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
                  height: 50,
                ),
                _usernamePasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password ?',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                _divider(),
                _googleFacebookLogin(),
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
          Align(
            alignment: Alignment.topCenter,
            child: _createAccountLabel(),
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
