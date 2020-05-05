import 'package:budgetgo/model/trips_class.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';

class DeleteMembers extends StatefulWidget {
  final Trips tripData;
  DeleteMembers(this.tripData);

  @override
  _DeleteMembersState createState() => _DeleteMembersState();
}

class _DeleteMembersState extends State<DeleteMembers> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Manage Member",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
