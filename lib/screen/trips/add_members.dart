import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:flutter/material.dart';

class AddMember extends StatefulWidget {
  final Trips dummyTrips;
  AddMember(this.dummyTrips);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<User> _friendList = List<User>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Add Member",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(tabs: [
            Container(
              child: Text("Hi"),
            ),
            Container(
              child: Text("Hi"),
            ),
            Container(
              child: Text("Hi"),
            ),
          ]),
          elevation: 0,
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              color: Colors.pink,
              child: Center(child: Text("Call Tab")),
            ),
            Container(
              color: Colors.pink,
              child: Center(child: Text("Call Tab")),
            ),
            Container(
              color: Colors.blue,
              child: Center(child: Text("Call Tab")),
            ),
          ],
        ),
      ),
    );
  }
}
