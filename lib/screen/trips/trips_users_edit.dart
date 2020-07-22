import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_user_checkbox.dart';
import 'package:flutter/material.dart';

class EditUserList extends StatefulWidget {
  EditUserList(this.user, this.userList);
  User user;
  List<User> userList;
  @override
  _EditUserState createState() {
    return new _EditUserState();
  }
}
class _EditUserState extends State<EditUserList> {
  

  @override
  Widget build(BuildContext context) {
    //List<User> members = widget.user.friend;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Edit User"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(child: new ListView(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: widget.userList.map((User user) {
                  return new FriendUserList(user);
                }).toList(),
              )),
              new RaisedButton(onPressed: () {
                    Navigator.pop(context, widget.userList);
              },
                child: new Text('Save'),
              )
            ],
          ),
        )
    );
  }
}