import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/notification_class.dart';
import 'package:budgetgo/screen/trips/trips_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../widget/custom_shape.dart';
import '../../main.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  //Dummy notification
  List<Notifications> dummyList = <Notifications>[];
  @override
  Widget build(BuildContext context) {
    dummyList.add(Notifications("Bali Trip", false, "3 mins ago", "John"));
    dummyList.add(Notifications("Thailand Trip", false, "14:15", "Chan"));
    dummyList.add(Notifications("Korea Trip", true, "11:55", "Looi"));
    dummyList.add(Notifications("Genting Trip", true, "3 days ago", "Tan"));
    dummyList.add(Notifications("Langkawi Trip", true, "10 days ago", "Chin"));
    dummyList.add(Notifications("Japan Trip", true, "30 days ago", "Yang"));

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
              itemCount: dummyList.length,
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
      color: Colors.grey.shade500,
    );
  }

  Slidable buildNoticeList(BuildContext ctxt, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: buildNoticeListTile(index),
      secondaryActions: <Widget>[
        buildIconSlideAction("More", Colors.black45, Icons.more_horiz),
        buildIconSlideAction("Delete", Colors.red, Icons.delete),
      ],
    );
  }

  IconSlideAction buildIconSlideAction(
      String caption, Color colors, IconData icons) {
    return IconSlideAction(
      caption: caption,
      color: colors,
      icon: icons,
      onTap: () {},
    );
  }

  ListTile buildNoticeListTile(int index) {
    return ListTile(
      selected: true,
      leading: Container(
        child: dummyList[index].status
            ? NoticeIcons(
                icons: Icons.notifications_none,
                status: dummyList[index].status)
            : NoticeIcons(
                icons: Icons.notification_important,
                status: dummyList[index].status),
      ),
      contentPadding: const EdgeInsets.all(7.0),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15.0,
      ),
      title: buildTitle(index, dummyList[index].status),
      subtitle: Text(
        "${dummyList[index].username} created a trip group. You are invited. Check it more!",
        style: TextStyle(
            color: key.currentState.brightness == Brightness.dark
                ? Colors.white
                : Colors.black26),
      ),
      onTap: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => TripsDetail()));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TripsDetail(mockdata[index])));
      },
    );
  }

  Row buildTitle(int index, bool status) {
    return Row(children: <Widget>[
      Text(
        dummyList[index].title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: status ? FontWeight.w500 : FontWeight.bold,
          color: key.currentState.brightness == Brightness.dark
              ? Colors.white
              : Colors.black87,
        ),
      ),
      SizedBox(
        width: 16.0,
      ),
      Text(
        dummyList[index].time,
        style: TextStyle(
            fontSize: 12.0,
            color: key.currentState.brightness == Brightness.dark
                ? Colors.white
                : Colors.black26),
      ),
    ]);
  }
}

class NoticeIcons extends StatelessWidget {
  const NoticeIcons({
    Key key,
    @required this.icons,
    @required this.status,
  }) : super(key: key);

  final IconData icons;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return status
        ? Icon(
            icons,
            size: 35.0,
          )
        : Stack(
            children: <Widget>[
              Icon(
                icons,
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
          );
  }
}
