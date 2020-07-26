import 'package:budgetgo/screen/login/forgot_password.dart';
import 'package:budgetgo/screen/register/register.dart';
import 'package:budgetgo/model/base_auth.dart';
import 'package:budgetgo/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import '../../widget/bezier_container.dart';
import '../home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  final toggleBrightness;
  final BaseAuth auth = new Auth();
  LoginPage({Key key, @required this.toggleBrightness}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _showPassword = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void signInViaEmail(email, password) async {
    _showSigninLoadingDialog();
    try {
      final uid = await widget.auth.signIn(email, password);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => MyHomePage(
                  toggleBrightness: widget.toggleBrightness,
                  auth: widget.auth,
                  uid: uid)));
    } catch (error) {
      _showErrorDialog(error);
    }
  }

  void signInViaGoogle() async {
    try {
      final result = await widget.auth.signInViaGoogle();

      if (result != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => MyHomePage(
                    toggleBrightness: widget.toggleBrightness,
                    auth: widget.auth,
                    uid: result.uid)));
      }
    } catch (error) {
      _showErrorDialog(error);
    }
  }

  signInFb() async {
    try {
      var result = await widget.auth.signInViaFacebook();
      if (result != null)
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => MyHomePage(
                    toggleBrightness: widget.toggleBrightness,
                    auth: widget.auth,
                    uid: result.uid)));
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Message'),
                content: Text('Error occurred. ${e.message}'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'))
                ],
              ));
    }
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
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: _buildForgotPassword(context),
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

  Container _formEntryField(
      {String title,
      TextEditingController controller,
      bool validate,
      String errorText,
      IconButton icon}) {
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
              controller: controller,
              style: TextStyle(color: Colors.black, height: 1.0, fontSize: 18),
              obscureText: title == "Password" ? _showPassword : false,
              decoration: InputDecoration(
                  suffixIcon: title == "Password" ? icon : null,
                  errorText: validate ? '$errorText' : null,
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
          _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;
        });

        if (_email.text.isNotEmpty && _password.text.isNotEmpty)
          signInViaEmail(_email.text, _password.text);
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
              onPressed: () => signInFb(),
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
              onPressed: () => signInViaGoogle(),
              text: 'Google',
              textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
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

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _formEntryField(
            title: "Email",
            controller: _email,
            errorText: 'The email field cannot be empty',
            validate: _validateEmail),
        _formEntryField(
          title: "Password",
          controller: _password,
          errorText: "The password field cannot be empty",
          validate: _validatePassword,
          icon: IconButton(
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              icon: _showPassword
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off)),
        )
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

  Future _showErrorDialog(error) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text(error.toString()),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                },
              )
            ],
          );
        });
  }

  Future _showSigninLoadingDialog() {
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
                            'Authenticating...',
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

  GestureDetector _buildForgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PasswordReset(
                    toggleBrightness: widget.toggleBrightness,
                    auth: widget.auth,
                  ))),
      child: Text('Forgot Password ?',
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
    );
  }
}
