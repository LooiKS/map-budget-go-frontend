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
    _oldPassword.dispose();
    _confirmNewPassword.dispose();
    super.dispose();
  }

  void validateEmail() {
    setState(() {
      if (_currentEmail.text.isEmpty) {
        _validateEmail = true;
      } else if (_currentEmail.text == widget.email &&
          _currentEmail.text.isNotEmpty) {
        _validateEmail = false;
        _buildPasswordEntryDialog(context);
      } else if (!RegExp(r'[\w\.-]+@[\w\.-]+\.\w{2,4}')
          .hasMatch(_currentEmail.text)) {
        _validateEmail = false;
        _showErrorDialog(
            error: "Please enter valid email address",
            title: "Email Incorrect",
            popCount: 1);
      } else {
        _validateEmail = false;
        _showErrorDialog(
            error: "Your email is not match.",
            title: "Email Incorrect",
            popCount: 1);
      }
    });
  }

  void resetPassword() async {
    if (_oldPassword.text.isNotEmpty &&
        _newPassword.text.isNotEmpty &&
        _confirmNewPassword.text.isNotEmpty) {
      if (_newPassword.text != _confirmNewPassword.text) {
        _showErrorDialog(
            error: "The new password does not match with confirm password.",
            popCount: 1,
            title: "Mismatch");
      } else {
        try {
          _showLoadingDialog();
          await widget.auth
              .changePassword(_oldPassword.text, _newPassword.text);
          _showUpdateSuccessDialog();
        } catch (error) {
          _showErrorDialog(
              error: error.toString(), title: "Error Occurs", popCount: 2);
        }
      }
    }
  }

  void handleCancelResetPassword() {
    setState(() {
      _validateOldPassword = false;
      _validateNewPassword = false;
      _validateConfirmPassword = false;
      _oldPassword.clear();
      _newPassword.clear();
      _confirmNewPassword.clear();
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Password"),
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
                    _buildTextEntryTitle("Re-Enter Your Email"),
                    SizedBox(
                      height: 10,
                    ),
                    _buildEmailTextField()
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildEmailButtonGroup(
                        context: context, title: "Cancel", color: Colors.red),
                    _buildEmailButtonGroup(
                        context: context, title: "Submit", color: Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  TextField _buildEmailTextField() {
    return TextField(
        controller: _currentEmail,
        style: TextStyle(color: Colors.black, height: 1.0, fontSize: 18),
        decoration: InputDecoration(
            errorText:
                _validateEmail ? 'The email field cannot be empty' : null,
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
            contentPadding: const EdgeInsets.all(10.0)));
  }

  Expanded _buildEmailButtonGroup(
      {BuildContext context, String title, Color color}) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
            child: RaisedButton(
          child: Text("$title"),
          textColor: Colors.white,
          color: color,
          onPressed: () =>
              title == "Cancel" ? Navigator.of(context).pop() : validateEmail(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        )),
      ),
    );
  }

  Future _buildPasswordEntryDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    _buildTextEntryTitle("Old Password"),
                    _buildPasswordTextField(
                        setState: setState,
                        controller: _oldPassword,
                        showHide: _showOldPassword,
                        validate: _validateOldPassword,
                        passwordType: 1,
                        errorText: 'The old password field cannot be empty.',
                        hintText: "Enter old password"),
                    SizedBox(
                      height: 10,
                    ),
                    _buildTextEntryTitle("New Password"),
                    _buildPasswordTextField(
                        setState: setState,
                        controller: _newPassword,
                        showHide: _showNewPassword,
                        validate: _validateNewPassword,
                        passwordType: 2,
                        errorText: 'The new password field cannot be empty.',
                        hintText: "Enter new password"),
                    SizedBox(
                      height: 10,
                    ),
                    _buildTextEntryTitle("Confirm New Password"),
                    _buildPasswordTextField(
                        setState: setState,
                        controller: _confirmNewPassword,
                        showHide: _showConfirmNewPassword,
                        validate: _validateConfirmPassword,
                        passwordType: 3,
                        errorText:
                            'The confirm password field cannot be empty.',
                        hintText: "Enter confirm new password"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildPasswordButtonGroup(
                            title: "Cancel", color: Colors.red),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                                child: RaisedButton(
                              child: Text("Reset"),
                              textColor: Colors.white,
                              color: Colors.green,
                              onPressed: () {
                                setState(() {
                                  _oldPassword.text.isEmpty
                                      ? _validateOldPassword = true
                                      : _validateOldPassword = false;
                                  _newPassword.text.isEmpty
                                      ? _validateNewPassword = true
                                      : _validateNewPassword = false;
                                  _confirmNewPassword.text.isEmpty
                                      ? _validateConfirmPassword = true
                                      : _validateConfirmPassword = false;
                                });
                                resetPassword();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
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
  }

  Expanded _buildPasswordButtonGroup({String title, Color color}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
            child: RaisedButton(
          child: Text("$title"),
          textColor: Colors.white,
          color: color,
          onPressed: () => handleCancelResetPassword(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        )),
      ),
      flex: 2,
    );
  }

  TextField _buildPasswordTextField({
    StateSetter setState,
    TextEditingController controller,
    bool showHide,
    int passwordType,
    String hintText,
    String errorText,
    bool validate,
  }) {
    return TextField(
      controller: controller,
      obscureText: showHide,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              switch (passwordType) {
                // 1 : Old Password
                // 2 : New Password
                // 3 : Confirm New Password
                case 1:
                  setState(() {
                    _showOldPassword = !showHide;
                    showHide = !showHide;
                  });
                  break;
                case 2:
                  setState(() {
                    _showNewPassword = !showHide;
                    showHide = !showHide;
                  });
                  break;
                case 3:
                  setState(() {
                    _showConfirmNewPassword = !showHide;
                    showHide = !showHide;
                  });
                  break;
              }
            },
            icon: Icon(showHide ? Icons.visibility : Icons.visibility_off)),
        hintText: "$hintText",
        errorText: validate ? '$errorText' : null,
      ),
    );
  }

  Text _buildTextEntryTitle(String text) {
    return Text(
      "$text",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            'Reseting...',
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

  Future _showErrorDialog({String error, String title, int popCount}) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('$title'),
              content: Text('$error'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return popCount == 2 ? count++ == 2 : count++ == 1;
                      });
                    },
                    child: Text('OK'))
              ],
            ));
  }

  Future _showUpdateSuccessDialog() {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Update Successfully'),
              content: Text('Password update successfully.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      handleCancelResetPassword();
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    },
                    child: Text('OK'))
              ],
            ));
  }
}
