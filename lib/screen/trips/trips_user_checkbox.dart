import 'package:budgetgo/model/user.dart';
import 'package:flutter/material.dart';
class FriendUserList extends StatefulWidget{
  final User user;
  FriendUserList(User user)
      : user = user,
        super(key: new ObjectKey(user));
  @override
  FriendUserState createState() {
    return new FriendUserState(user);
  }
}
class FriendUserState extends State<FriendUserList> {
  final User user;
  FriendUserState(this.user);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap:null,
         leading: new CircleAvatar(
           //backgroundColor: Colors.blue,
           child: user.profilePic == null ? Image.asset('assets/images/default_profile.png') : Image.network(user.profilePic),
         ),
        title: new Row(
          children: <Widget>[
            new Expanded(child: new Text(user.firstName+" "+user.lastName)),
            
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