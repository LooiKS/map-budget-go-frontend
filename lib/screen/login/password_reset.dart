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

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Widget _title() {
    return Text(
      "Reset Password",
      style: TextStyle(fontSize: 30),
    );
  }

  Widget _emailEntryField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email Address",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _email,
              style:
                  TextStyle(color: Colors.black, height: 1.0, fontSize: 18.0),
              decoration: InputDecoration(
                  hintText: "e.g. email@domain.com",
                  errorText:
                      _validateEmail ? 'The email field cannot be empty' : null,
                  border: OutlineInputBorder(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0)))
        ],
      ),
    );
  }

  Widget _submitButton({BuildContext context}) {
    return InkWell(
      onTap: () async {
        setState(() {
          _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;
        });
        if (!_validateEmail) {
          try {
            await widget.auth.resetPassword(_email.text);
            return _resetPasswordAlert(
                context, "Password reset email sent. Please check your entered email.", "Email Sent");
          } catch (error) {
            return _resetPasswordAlert(
                context, error.toString(), "Reset Error");
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

  Future<void> _resetPasswordAlert(
      BuildContext context, String message, String title) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: Text('$message'),
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                      "Enter your email address and we'll send you a link to reset your password.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                    SizedBox(
                      child: Divider(
                        thickness: 1,
                      ),
                      height: 50,
                    ),
                    _emailEntryField(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(context: context),
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
