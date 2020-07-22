import 'package:budgetgo/model/base_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import '../../widget/bezier_container.dart';

class PasswordReset extends StatefulWidget {
  final toggleBrightness;
  final BaseAuth auth;
  PasswordReset({Key key, @required this.toggleBrightness, this.auth})
      : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  bool _validateEmail = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.green.withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.green),
        child: Text(
          'Reset Password',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      "Reset Password",
      style: TextStyle(fontSize: 30),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _emailEntryField("Email Address"),
      ],
    );
  }

  Widget _emailEntryField(String title) {
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
              controller: _email,
              style:
                  new TextStyle(color: Colors.black, height: 1.0, fontSize: 18),
              decoration: InputDecoration(
                  errorText:
                      _validateEmail ? 'The email field cannot be empty' : null,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0)))
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
              'The email and password are not matched. Please try again'),
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
                  height: 165,
                ),
                _title(),
                SizedBox(
                  height: 50,
                ),
                Text(
                    "Enter your email address and we'll send you a link to reset your password."),
                    SizedBox(width: 50,)
                Container(
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
                ),
                SizedBox(
                  height: 50,
                ),
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
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
