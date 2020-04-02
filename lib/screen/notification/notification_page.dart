import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../widget/custom_shape.dart';
import '../trips/trips_detail.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> noticeTitle = [
    "Bali Trip",
    "Thailand Trip",
    "Korea Trip",
    "Malaysia Trip",
    "Langkawi Trip"
  ];

  List<String> dummyName = ["John", "Chan", "Looi", "Tan", "Chin"];
  List<String> dummyTime = [
    "14 mins ago",
    "2 hours ago",
    "12 hours ago",
    "3 days ago",
    "10 days ago"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: CustomShapeBorder(),
        actions: <Widget>[
          Icon(
            Icons.notifications_active,
            color: Colors.white,
          )
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        shrinkWrap: true,
        itemBuilder: (BuildContext ctxt, int index) =>
            buildNoticeList(ctxt, index),
        itemCount: noticeTitle.length,
      ),
    );
  }

  Slidable buildNoticeList(BuildContext ctxt, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        selected: true,
        leading: Container(
          child: index < 2
              ? Stack(
                  children: <Widget>[
                    Icon(
                      Icons.notification_important,
                      size: 35.0,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 10,
                          maxHeight: 10,
                        ),
                      ),
                    )
                  ],
                )
              : Icon(
                  Icons.notifications_none,
                  size: 35.0,
                ),
        ),
        contentPadding: EdgeInsets.all(2.0),
        trailing: Text(
          dummyTime[index],
          style: TextStyle(color: Colors.black54),
        ),
        title: index < 2
            ? Text(
                noticeTitle[index],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )
            : Text(
                noticeTitle[index],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
              ),
        // isThreeLine: true,
        subtitle: Text(
          "${dummyName[index]} created a trip group. You are invited. Check it more!",
          style: TextStyle(color: Colors.black26),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TripsDetail()));
        },
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}
