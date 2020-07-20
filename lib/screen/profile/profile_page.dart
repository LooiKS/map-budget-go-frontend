import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/services/users_date_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../main.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({this.user});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  TextEditingController _username;
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _mobilePhone;

  @override
  void initState() {
    _username = TextEditingController(text: ('${widget.user.username}'));
    _firstName = TextEditingController(text: ('${widget.user.firstName}'));
    _lastName = TextEditingController(text: ('${widget.user.lastName}'));
    _mobilePhone = TextEditingController(text: ('${widget.user.phoneNum}'));
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Future updateProfile() async {
    User user = User.copy(widget.user);
    print(user.friend[0].id);
    user.username = _username.text;
    user.firstName = _firstName.text;
    user.lastName = _lastName.text;
    user.phoneNum = _mobilePhone.text;
    await userDataService.updateUser(id: widget.user.id, user: user);

    setState(() {
      _status = true;
      FocusScope.of(context).requestFocus(FocusNode());
    });

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Message'),
          content: const Text('Your profile updated successfully.'),
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
    const borderSide = BorderSide(width: 4.0);
    return Scaffold(
        body: Container(
      child: ListView(
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
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Row(
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
                              child: Text('PROFILE',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              buildTitle('Personal Information'),
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
                                      _status ? _getEditIcon() : Container(),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                      InfoTitle('User ID'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: TextEditingController()
                                    ..text = '${widget.user.id}',
                                  enabled: false,
                                ),
                              ),
                            ],
                          )),
                      InfoTitle('Username'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _username,
                                  // TextEditingController()
                                  //   ..text = '${widget.user.username}',
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Username",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      InfoTitle('First Name'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _firstName,
                                  // TextEditingController()
                                  //   ..text = '${widget.user.firstName}',
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      InfoTitle('Last Name'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _lastName,
                                  // TextEditingController()
                                  //   ..text = '${widget.user.lastName}',
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      InfoTitle('Mobile Number'),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _mobilePhone,
                                  // TextEditingController()
                                  //   ..text = '${widget.user.phoneNum}',
                                  decoration: const InputDecoration(
                                      hintText: "Enter Mobile Number"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      !_status ? _getActionButtons() : Container(),
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
      child: Text("Reset Password"),
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
                        buildTitle("Reset Password"),
                        InfoTitle('Old Password'),
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: TextField(
                                    controller: TextEditingController()
                                      ..text = '${widget.user.id}',
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        InfoTitle('New Password'),
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: TextField(
                                    controller: TextEditingController()
                                      ..text = '${widget.user.id}',
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        InfoTitle('Confirm New Password'),
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: TextField(
                                    controller: TextEditingController()
                                      ..text = '${widget.user.id}',
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ));
            });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
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

  Padding buildProfileImage() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Stack(fit: StackFit.loose, children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3),
                  image: DecorationImage(
                    image: NetworkImage('${widget.user.profilePic}'),
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 90.0, right: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 25.0,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                )
              ],
            )),
      ]),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  await updateProfile();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _username.text = widget.user.username;
                    _firstName.text = widget.user.firstName;
                    _lastName.text = widget.user.lastName;
                    _mobilePhone.text = widget.user.phoneNum;
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
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
        child: TextField(
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
        child: Text(
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
        child: Row(
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
