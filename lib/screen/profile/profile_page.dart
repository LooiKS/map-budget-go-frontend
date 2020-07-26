import 'package:budgetgo/model/base_auth.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/profile/update_password.dart';
import 'package:budgetgo/services/users_date_service.dart';
import 'package:budgetgo/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final BaseAuth auth;
  ProfilePage({this.user, this.auth});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  TextEditingController _username;
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _mobilePhone;
  int _genderValue = -1;

  @override
  void initState() {
    _username = TextEditingController(
        text: widget.user.username == null ? "" : ('${widget.user.username}'));
    _firstName = TextEditingController(
        text:
            widget.user.firstName == null ? "" : ('${widget.user.firstName}'));
    _lastName = TextEditingController(
        text: widget.user.lastName == null ? "" : ('${widget.user.lastName}'));
    _mobilePhone = TextEditingController(
        text: widget.user.phoneNum == null ? "" : ('${widget.user.phoneNum}'));
    if (widget.user.gender == null || widget.user.gender == "-1")
      _genderValue = -1;
    widget.user.gender == "Male" ? _genderValue = 0 : _genderValue = 1;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _username.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _mobilePhone.dispose();
    super.dispose();
  }

  Future updateProfile() async {
    if (!_status) _showLoadingDialog();

    User user = User.copy(widget.user);
    user.username = _username.text;
    user.firstName = _firstName.text;
    user.lastName = _lastName.text;
    user.phoneNum = _mobilePhone.text;

    if (_genderValue == null || _genderValue == -1) user.gender = "-1";
    _genderValue == 1 ? user.gender = "Female" : user.gender = "Male";

    await userDataService.updateUser(id: widget.user.id, user: user);
    Utils.user = user;
    setState(() {
      _status = true;
    });

    return _showSuccessUpdateDialog();
  }

  void _handleCancel() {
    setState(() {
      _username.text = widget.user.username == null ? "" : widget.user.username;
      _firstName.text =
          widget.user.firstName == null ? "" : widget.user.firstName;
      _lastName.text = widget.user.lastName == null ? "" : widget.user.lastName;
      _mobilePhone.text =
          widget.user.phoneNum == null ? "" : widget.user.phoneNum;
      if (widget.user.gender == null) _genderValue = -1;
      widget.user.gender == "Male" ? _genderValue = 0 : _genderValue = 1;
      _status = true;
    });
  }

  void _handleRadioValueChanged(int value) {
    setState(() {
      this._genderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                      buildResetPasswordButton(context),
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
                      SizedBox(height: 15.0),
                      _buildFixedField(
                          title: "User ID",
                          defaultText: "${widget.user.id}",
                          enabled: false),
                      SizedBox(height: 15.0),
                      _buildInputEntry(
                          title: "Username",
                          controller: _username,
                          hintText: "Enter your username",
                          autofocus: !_status,
                          enabled: !_status),
                      SizedBox(height: 15.0),
                      _buildInputEntry(
                          title: "First Name",
                          controller: _firstName,
                          hintText: "Enter your first name",
                          autofocus: !_status,
                          enabled: !_status),
                      SizedBox(height: 15.0),
                      _buildInputEntry(
                          title: "Last Name",
                          controller: _lastName,
                          hintText: "Enter your last name",
                          autofocus: !_status,
                          enabled: !_status),
                      SizedBox(height: 15.0),
                      _buildInputEntry(
                          title: "Mobile Number",
                          controller: _mobilePhone,
                          hintText: "Enter your mobile number",
                          autofocus: !_status,
                          enabled: !_status),
                      SizedBox(height: 15.0),
                      _buildGenderInputEntry(),
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

  Padding _buildGenderInputEntry() {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Gender",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  _buildRadioButton(
                      value: 0, groupValue: _genderValue, status: !_status),
                  _buildGenderText("Male"),
                  _buildRadioButton(
                      value: 1, groupValue: _genderValue, status: !_status),
                  _buildGenderText("Female"),
                ],
              )
            ]));
  }

  Text _buildGenderText(String gender) {
    return Text(
      "$gender",
      style: TextStyle(
        fontSize: 14.0,
      ),
    );
  }

  Radio<int> _buildRadioButton({int value, int groupValue, bool status}) {
    return Radio(
        value: value,
        groupValue: groupValue,
        onChanged: status ? _handleRadioValueChanged : null);
  }

  Padding _buildInputEntry(
      {String title,
      TextEditingController controller,
      String hintText,
      bool enabled,
      bool autofocus}) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "$hintText",
            ),
            enabled: enabled,
            autofocus: autofocus,
          ),
        ],
      ),
    );
  }

  Padding _buildFixedField({String title, String defaultText, bool enabled}) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: TextEditingController()..text = '$defaultText',
            enabled: enabled,
          ),
        ],
      ),
    );
  }

  RaisedButton buildResetPasswordButton(BuildContext context) {
    return RaisedButton(
      child: Text("Reset Password"),
      textColor: Colors.white,
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdatePasswordPage(
                    email: widget.user.email, auth: widget.auth)));
      },
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
                    image: widget.user.profilePic == null
                        ? AssetImage("assets/images/default_profile.png")
                        : NetworkImage(
                            '${widget.user.profilePic}',
                          ),
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
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      ImagePicker()
                          .getImage(source: ImageSource.gallery)
                          .then((pickedFile) async {
                        if (pickedFile != null) {
                          var bytes = await pickedFile.readAsBytes();
                          userDataService.uploadPhoto(
                              bytes: bytes,
                              fileName: pickedFile.path.split('/').last,
                              user: widget.user);
                          setState(() {});
                        }
                      });
                    },
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                  ),
                )
              ],
            )),
      ]),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
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
                onPressed: () => _handleCancel(),
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

  Future _showSuccessUpdateDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Message'),
          content: const Text('Your profile updated successfully.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
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
                            'Updating....',
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
