import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_user_checkbox.dart';
import 'package:flutter/material.dart';

class EditUserList extends StatefulWidget {
//  EditUserList(Users user, {Key key, this.user}) :super(key: key);
  EditUserList(this.members,this.user);
  List<Users> members;
  Users user;
  @override
  _EditUserState createState() {
    return new _EditUserState();
  }
}
class _EditUserState extends State<EditUserList> {
  
  @override
  Widget build(BuildContext context) {
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
                children: widget.members.map((Users user) {
                  return new FriendUserList(user);
                }).toList(),
              )),
              new RaisedButton(onPressed: () {
                for (Users p in widget.members) {
                  if (p.isChecked)
                    print(p.userName);
                }
                
                    Navigator.pop(context, widget.members);
              },
                child: new Text('Save'),
              )
            ],
          ),
        )
    );
  }
}