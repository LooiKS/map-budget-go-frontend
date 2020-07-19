import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:  Container(
      child:  ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
               Container(
                height: 250.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xfffbb448), Color(0xfff7892b)]),
                ),
                child:  Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.black,
                              iconSize: 22.0,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0, top: 12.0),
                              child:  Text('PROFILE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black)),
                            )
                          ],
                        )),
                    buildProfileImage()
                  ],
                ),
              ),
               Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              buildTitle(),
                               Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      buildQRButton(context),
                                      Padding(
                                        padding: EdgeInsets.only(right: 15.0),
                                      ),
                                      _status
                                          ? _getEditIcon()
                                          :  Container(),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child:  Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ExpendedTitle('Username'),
                              ExpendedTitle('User ID'),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child:  Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              FixedFieldValue('maria97'),
                              FixedFieldValue('BG00010'),
                            ],
                          )),
                      InfoTitle('Name'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child:  Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                               Flexible(
                                child:  TextField(
                                  controller: TextEditingController()
                                    ..text = 'Maria Chin',
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      InfoTitle('Email Address'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child:  Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                               Flexible(
                                child:  TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email Address"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      InfoTitle('Password'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child:  Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                               Flexible(
                                child:  TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Enter Password"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      InfoTitle('Mobile Number'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child:  Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                               Flexible(
                                child:  TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Enter Mobile Number"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      !_status ? _getActionButtons() :  Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  RaisedButton buildQRButton(BuildContext context) {
    return RaisedButton(
      child:  Text("Qr Code"),
      textColor: Colors.white,
      color: Colors.red,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    height: 450.0,
                    width: 500.0,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image:  ExactAssetImage('assets/images/frame.png'),
                        )
                      ],
                    ),
                  ));
            });
      },
      shape:  RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(20.0)),
    );
  }

  Column buildTitle() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
         Text(
          'Personal Information',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Padding buildProfileImage() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child:  Stack(fit: StackFit.loose, children: <Widget>[
         Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Container(
                width: 140.0,
                height: 140.0,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3),
                  image:  DecorationImage(
                    image:  ExactAssetImage('assets/images/as.png'),
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 90.0, right: 100.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 25.0,
                  child:  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                )
              ],
            )),
      ]),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child:  Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child:  RaisedButton(
                child:  Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus( FocusNode());
                  });
                },
                shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child:  RaisedButton(
                child:  Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus( FocusNode());
                  });
                },
                shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return  GestureDetector(
      child:  CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child:  Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}

class FixedFieldValue extends StatelessWidget {
  const FixedFieldValue(this.value);
  final value;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child:  TextField(
          controller: TextEditingController()..text = value,
          enabled: false,
        ),
      ),
      flex: 2,
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
        child:  Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      flex: 2,
    );
  }
}

class InfoTitle extends StatelessWidget {
  final title;
  const InfoTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
        child:  Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}
