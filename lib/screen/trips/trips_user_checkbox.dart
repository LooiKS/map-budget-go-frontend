import 'package:budgetgo/model/user.dart';
import 'package:flutter/material.dart';
class FriendUserList extends StatefulWidget{
  final Users user;
  FriendUserList(Users user)
      : user = user,
        super(key: new ObjectKey(user));
  @override
  FriendUserState createState() {
    return new FriendUserState(user);
  }
}
class FriendUserState extends State<FriendUserList> {
  final Users user;
  FriendUserState(this.user);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap:null,
         leading: new CircleAvatar(
           //backgroundColor: Colors.blue,
           child: new Image.network(user.imageURL),
         ),
        title: new Row(
          children: <Widget>[
            new Expanded(child: new Text(user.userName)),
            new Checkbox(value: user.isChecked, onChanged: (bool value) {
              setState(() {
                user.isChecked = value;
              });
            })
          ],
        )
    );
  }
}