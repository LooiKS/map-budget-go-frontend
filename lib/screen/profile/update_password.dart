import 'package:budgetgo/model/base_auth.dart';
import 'package:budgetgo/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String email;
  final BaseAuth auth;
  UpdatePasswordPage({this.email, this.auth});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<UpdatePasswordPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _currentEmail = TextEditingController();
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmNewPassword = TextEditingController();

  bool _validateEmail = false;
  bool _validateOldPassword = false;
  bool _validateNewPassword = false;
  bool _validateConfirmPassword = false;
  bool _showOldPassword = true;
  bool _showNewPassword = true;
  bool _showConfirmNewPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _currentEmail.dispose();
    _newPassword.dispose();
    super.dispose();
  }

  void resetPassword() async {
    if (_oldPassword.text.isEmpty) {
      setState(() {
        _validateOldPassword = true;
      });
    }
    if (_newPassword.text.isEmpty) {
      setState(() {
        _validateNewPassword = true;
      });
    }
    if (_confirmNewPassword.text.isEmpty) {
      setState(() {
        _validateConfirmPassword = true;
      });
    }
    if (_oldPassword.text.isNotEmpty &&
        _newPassword.text.isNotEmpty &&
        _confirmNewPassword.text.isNotEmpty &&
        (_confirmNewPassword.text == _newPassword.text)) {
      try {
        await widget.auth.changePassword(_oldPassword.text, _newPassword.text);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Update Successfully'),
                  content: Text('Password update successfully.'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('OK'))
                  ],
                ));
      } catch (error) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Error Occurs'),
                  content: Text('${error.toString()}'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'))
                  ],
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Error'),
                content: Text(
                    'The new password does not match with confirm password.'),
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
        appBar: AppBar(
          title: Text("Reset Password"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Re-Enter Your Email",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _currentEmail,
                        style: TextStyle(
                            color: Colors.black, height: 1.0, fontSize: 18),
                        decoration: InputDecoration(
                            errorText: _validateEmail
                                ? 'The email field cannot be empty'
                                : null,
                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10.0)))
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            child: RaisedButton(
                          child: Text("Cancel"),
                          textColor: Colors.white,
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        )),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            child: RaisedButton(
                          child: Text("Submit"),
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: () async {
                            if (_currentEmail.text.isEmpty) {
                              setState(() {
                                _validateEmail = true;
                              });
                            } else if (_currentEmail.text == widget.email &&
                                _currentEmail.text.isNotEmpty) {
                              setState(() {
                                _validateEmail = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 400,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: ListView(
                                            children: [
                                              Text(
                                                "Old Password",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              TextField(
                                                controller: _oldPassword,
                                                obscureText: _showOldPassword,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _showOldPassword =
                                                              !_showOldPassword;
                                                        });
                                                      },
                                                      icon: Icon(_showOldPassword
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off)),
                                                  hintText:
                                                      "Enter old password",
                                                  errorText: _validateOldPassword
                                                      ? 'The old password field cannot be empty.'
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "New Password",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              TextField(
                                                controller: _newPassword,
                                                obscureText: _showNewPassword,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _showNewPassword =
                                                              !_showNewPassword;
                                                        });
                                                      },
                                                      icon: Icon(_showNewPassword
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off)),
                                                  hintText:
                                                      "Enter new password",
                                                  errorText: _validateNewPassword
                                                      ? 'The new password field cannot be empty.'
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Confirm New Password",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              TextField(
                                                controller: _confirmNewPassword,
                                                obscureText:
                                                    _showConfirmNewPassword,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _showConfirmNewPassword =
                                                              !_showConfirmNewPassword;
                                                        });
                                                      },
                                                      icon: Icon(
                                                          _showConfirmNewPassword
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off)),
                                                  hintText:
                                                      "Enter confirm new password",
                                                  errorText:
                                                      _validateConfirmPassword
                                                          ? 'The confirm password field cannot be empty.'
                                                          : null,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Container(
                                                          child: RaisedButton(
                                                        child: Text("Cancel"),
                                                        textColor: Colors.white,
                                                        color: Colors.red,
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                      )),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Container(
                                                          child: RaisedButton(
                                                        child: Text("Reset"),
                                                        textColor: Colors.white,
                                                        color: Colors.green,
                                                        onPressed: () {
                                                          resetPassword();
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                      )),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            } else {
                              setState(() {
                                _validateEmail = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Email Incorrect"),
                                      content: Text("Your email is not match."),
                                      actions: [
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        )),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Column buildTitle(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$title',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ExpendedTitle extends StatelessWidget {
  const ExpendedTitle(this.title);
  final title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      flex: 2,
    );
  }
}
