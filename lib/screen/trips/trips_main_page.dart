import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './trips_detail.dart';

class TripsMainPage extends StatefulWidget {
  @override
  _TripsMainPageState createState() => _TripsMainPageState();
}

class _TripsMainPageState extends State<TripsMainPage> {
  List<String> items = ["Trip To Bali", "Trip to Sky"];

  Widget buildList(BuildContext ctxt, int index) {
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: ListTile(
          selected: true,
          leading: Container(
            width: 48.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  Text(
                    "20 NOV",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(8.0),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30.0,
          ),
          title: Text(
            "${items[index]}",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          isThreeLine: true,
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.place),
                    Text("Bali, Indonesia")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/loading.gif",
                        image:
                            'https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg',
                        fit: BoxFit.contain,
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                    ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/loading.gif",
                        image:
                            'https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640',
                        fit: BoxFit.contain,
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                    CircleAvatar(
                      radius: 15.0,
                      child: Icon(Icons.more_horiz),
                    ),
                  ],
                ),
              ]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TripsDetail()),
            );
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: TabBar(
              tabs: <Widget>[
                Tab(
                    icon: Icon(Icons.notifications_active),
                    text: "In Progress"),
                Tab(
                  icon: Icon(Icons.schedule),
                  text: "Coming Soon",
                ),
                Tab(
                  icon: Icon(Icons.event_available),
                  text: "Past",
                ),
              ],
            )),
        body: TabBarView(children: <Widget>[
          Container(
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) =>
                  buildList(ctxt, index),
              itemCount: items.length,
            ),
          ),
          Container(child: Text("hi")),
          Container(child: Text("hi")),
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            "Add Trips",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          icon: Icon(
            Icons.location_on,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
