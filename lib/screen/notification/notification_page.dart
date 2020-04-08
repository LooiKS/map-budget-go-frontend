import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../widget/custom_shape.dart';
import '../trips/trips_detail.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Color titleColor = Colors.black87;
  Color subTitleColor = Colors.black45;

  List<String> noticeTitle = [
    "Bali Trip",
    "Thailand Trip",
    "Korea Trip",
    "Malaysia Trip",
    "Langkawi Trip",
    "Genting Trip"
  ];

  List<String> dummyName = ["John", "Chan", "Looi", "Tan", "Chin", "Yang"];

  List<String> dummyTime = [
    "14 mins ago",
    "14:15",
    "11:55",
    "3 days ago",
    "10 days ago",
    "30 days ago"
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
              size: 30.0,
              color: Colors.white70,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(height: 20.0),
            buildSearchBar(),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              separatorBuilder: (context, index) => buildDivider(),
              itemBuilder: (BuildContext ctxt, int index) =>
                  buildNoticeList(ctxt, index),
              itemCount: noticeTitle.length,
            ),
          ]),
        ));
  }

  Padding buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: TextField(
        onChanged: (value) {},
        // controller: editingController,
        decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      color: Colors.black,
    );
  }

  Slidable buildNoticeList(BuildContext ctxt, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: buildNoticeListTile(index),
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

  ListTile buildNoticeListTile(int index) {
    return ListTile(
      selected: true,
      leading: Container(
        child: index < 2 ? buildUnreadIcon() : buildReadedIcon(),
      ),
      contentPadding: const EdgeInsets.all(7.0),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15.0,
      ),
      title: index < 2 ? buildUnreadTitle(index) : buildReadedTitle(index),
      subtitle: Text(
        "${dummyName[index]} created a trip group. You are invited. Check it more!",
        style: TextStyle(color: subTitleColor),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TripsDetail()));
      },
    );
  }

  Icon buildReadedIcon() {
    return Icon(
      Icons.notifications_none,
      size: 35.0,
      color: titleColor,
    );
  }

  Stack buildUnreadIcon() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.notification_important,
          size: 35.0,
          color: titleColor,
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
    );
  }

  Row buildUnreadTitle(int index) {
    return Row(children: <Widget>[
      Text(
        noticeTitle[index],
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: titleColor),
      ),
      SizedBox(
        width: 16.0,
      ),
      Text(
        dummyTime[index],
        style: TextStyle(color: titleColor, fontSize: 12.0),
      ),
    ]);
  }

  Row buildReadedTitle(int index) {
    return Row(children: <Widget>[
      Text(
        noticeTitle[index],
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.normal, color: titleColor),
      ),
      SizedBox(
        width: 16.0,
      ),
      Text(
        dummyTime[index],
        style: TextStyle(color: titleColor, fontSize: 12.0),
      ),
    ]);
  }
}
