import 'package:budgetgo/model/base_auth.dart';
import 'package:flutter/material.dart';
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

  Future sendEmail() async {
    if (_email.text.isEmpty) {
      setState(() {
        _validateEmail = true;
      });
    } else if (!RegExp(r'[\w\.-]+@[\w\.-]+\.\w{2,4}').hasMatch(_email.text)) {
      setState(() {
        _validateEmail = false;
      });
      _resetPasswordAlert(
          context: context,
          message: "Please enter valid email address",
          title: "Email Incorrect");
    } else {
      setState(() {
        _validateEmail = false;
      });
      try {
        _showLoadingDialog();
        await widget.auth.resetPassword(_email.text);
        return _resetPasswordAlert(
            context: context,
            title: "Email Sent",
            message:
                "Password reset email sent. Please check your entered email.",
            popCount: 2);
      } catch (error) {
        return _resetPasswordAlert(
            context: context,
            message: error.toString(),
            title: "Reset Error",
            popCount: 2);
      }
    }
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
      onTap: () => sendEmail(),
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

  Future _resetPasswordAlert(
      {BuildContext context, String message, String title, int popCount}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: Text('$message'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  if (popCount == 2) return count++ == 2;
                  return count++ == 1;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future _showLoadingDialog() {
    return showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sending email....',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
