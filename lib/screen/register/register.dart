import 'package:budgetgo/model/base_auth.dart';
import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/login/login.dart';
import 'package:budgetgo/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import '../../widget/bezier_container.dart';
import '../home_page/home_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  bool _passwordObsure = true;
  bool _retypePasswordObsure = true;
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _retypePassword = TextEditingController();
  final _email = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  BaseAuth auth = Auth();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 125,
                      ),
                      _title(),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Registration',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      _usernamePasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: 10),
                      _divider(),
                      _googleFacebookLogin(),
                      Align(
                        alignment: Alignment.topCenter,
                        child: _createAccountLabel(),
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
          ),
        ),
      ),
    );
  }

  Widget _entryField(
      String title, Function validate, TextEditingController controller,
      [bool obsure = true]) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                    validator: validate,
                    controller: controller,
                    obscureText: obsure,
                    style: new TextStyle(
                        color: Colors.black, height: 1.0, fontSize: 18),
                    decoration: InputDecoration(
                        errorMaxLines: 10,
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        contentPadding: const EdgeInsets.all(10.0))),
              ),
              title.contains('Password')
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () => title.contains("Confirm")
                            ? setState(() =>
                                _retypePasswordObsure = !_retypePasswordObsure)
                            : setState(
                                () => _passwordObsure = !_passwordObsure),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          showDialog(
              context: context,
              builder: (_) => Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Loading...',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
          String res = await Auth().signUp(_email.text, _password.text);
          Navigator.pop(context);
          switch (res) {
            case null:
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Message'),
                        content: Text(
                            'The email is used, please try another or login using the account.'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'))
                        ],
                      ));
              break;
            default:
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Message'),
                        content: Text(
                            'Registration Done. Please verify your email.'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            LoginPage(toggleBrightness: null)),
                                    (predicate) => false);
                                _email.clear();
                                _username.clear();
                                _password.clear();
                                _retypePassword.clear();
                              },
                              child: Text('OK'))
                        ],
                      ));
              break;
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
          'Register',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Login here',
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
              text: 'Facebookk',
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
              onPressed: () => signInGoogle(),
              text: 'Google',
              textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
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
        _entryField("Email Address", validateEmail, _email, false),
        // _entryField("Username", validateUsername, _username, false),
        _entryField("Password", validatePassword, _password, _passwordObsure),
        _entryField("Confirm Password", validateRetypePassword, _retypePassword,
            _retypePasswordObsure),
      ],
    );
  }

  String validateEmail(String email) {
    return email.isEmpty
        ? "Email cannot be empty"
        : !RegExp(r'[\w\.-]+@[\w\.-]+\.\w{2,4}').hasMatch(email)
            ? 'Please enter valid email address'
            : null;
  }

  String validateUsername(String uname) {
    return uname.isEmpty ? "Username cannot be empty" : null;
  }

  String validatePassword(String password) {
    return password.isEmpty
        ? 'Password cannot be empty'
        : !RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$')
                .hasMatch(password)
            ? 'Password must contain uppercase and lowercase alphabet, and number(s). The length of the password must be at least 8.'
            : null;
  }

  String validateRetypePassword(String password) {
    return password != _password.text ? 'Password does not match' : null;
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
          Text('or sign up with'),
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

  signInGoogle() async {
    try {
      var result = await auth.signInViaGoogle();
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Message'),
                content: Text(
                    'Account registered successfully. You will be redirected to home page now.'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => MyHomePage()),
                          (_) => false),
                      child: Text('OK'))
                ],
              ));
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Message'),
                content: Text('Error occurred. ${e.message}'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => MyHomePage()),
                          (_) => false),
                      child: Text('OK'))
                ],
              ));
    }
  }

  signInFb() async {
    try {
      var result = await auth.signInViaFacebook();
      if (result != null)
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Message'),
                  content: Text(
                      'Account registered successfully. You will be redirected to home page now.'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => MyHomePage()),
                            (_) => false),
                        child: Text('OK'))
                  ],
                ));
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
}
