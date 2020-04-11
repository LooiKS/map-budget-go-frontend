import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './trips_detail.dart';
import '../../main.dart';

class TripsMainPage extends StatefulWidget {
  @override
  _TripsMainPageState createState() => _TripsMainPageState();
}

class _TripsMainPageState extends State<TripsMainPage> {
  List<String> dummyTrips = ["Trip To Bali", "Trip to Sky"];
  List<String> dummyLocation = ["Bali, Indonesia", "Genting, Malaysia"];

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
                buildTabBarTitle("In Progress", Icons.notifications_active),
                buildTabBarTitle("Coming Soon", Icons.schedule),
                buildTabBarTitle("Past", Icons.event_available),
              ],
            )),
        body: TabBarView(children: <Widget>[
          Container(
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) =>
                  buildInProgressList(ctxt, index),
              itemCount: dummyTrips.length,
            ),
          ),
          Container(child: Text("Coming Soon")),
          Container(child: Text("Past")),
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

  Tab buildTabBarTitle(String title, IconData icons) {
    return Tab(
      icon: Icon(icons),
      text: title,
    );
  }

  Card buildInProgressList(BuildContext ctxt, int index) {
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
                  Text("20 NOV",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(8.0),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.keyboard_arrow_right,
                size: 30.0,
              ),
            ],
          ),
          title: SizedBox(
            height: 27,
            child: Text(
              "${dummyTrips[index]}",
              style: TextStyle(
                  color: key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black54,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(Icons.place),
                    Text(
                      dummyLocation[index],
                      style: TextStyle(
                          color: key.currentState.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black54),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildMemberAvatar(
                        imageLink:
                            "https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg"),
                    buildMemberAvatar(
                        imageLink:
                            "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640"),
                    CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.more_horiz),
                        backgroundColor:
                            key.currentState.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black54),
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
          buildIconSlideAction("More", Colors.grey, Icons.more_horiz),
          buildIconSlideAction("Delete", Colors.red, Icons.delete),
        ],
      ),
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

  ClipOval buildMemberAvatar({String imageLink, bool icon}) {
    return ClipOval(
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/loading.gif",
        image: imageLink,
        fit: BoxFit.contain,
        width: 30.0,
        height: 30.0,
      ),
    );
  }
}
