import 'package:budgetgo/model/base_auth.dart';
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

  bool _validateEmail = false;
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _currentEmail.dispose();
    super.dispose();
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
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "New Password",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                obscureText: _showPassword,
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _showPassword =
                                                                !_showPassword;
                                                          });
                                                        },
                                                        icon: Icon(_showPassword
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off)),
                                                    hintText:
                                                        "Enter new password"),
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
                                                        child: Text("Submit"),
                                                        textColor: Colors.white,
                                                        color: Colors.green,
                                                        onPressed: () {},
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
