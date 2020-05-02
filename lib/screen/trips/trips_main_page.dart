import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import './trips_detail.dart';
import '../../main.dart';

class TripsMainPage extends StatefulWidget {
  final List<Trips> tripsData;
  TripsMainPage(this.tripsData);
  @override
  _TripsMainPageState createState() => _TripsMainPageState();
}

class _TripsMainPageState extends State<TripsMainPage> {
  List<Trips> progressTrips = [];
  List<Trips> upcomingTrips = [];
  List<Trips> pastTrips = [];
  void _navigateTripDetails(int index) async {
    Trips returnData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripsDetail(widget.tripsData[index]),
      ),
    );
    if (returnData != null) {
      setState(() => widget.tripsData[index] = returnData);
      setState(() {
        widget.tripsData.removeWhere((item) => item.tripDetail == 'cancel');
      });
    } else {}
  }

  void _navigateCreateTrip() async {
    Trips returnData = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TripsCreatePage()));
    if (returnData != null) {
      setState(() {
        widget.tripsData.add(returnData);
        _tripAddedAlert(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    progressTrips.clear();
    upcomingTrips.clear();
    pastTrips.clear();
    print(widget.tripsData.length);
    for (int i = 0; i < widget.tripsData.length; i++) {
      if (widget.tripsData[i].startDt.isBefore(DateTime.now()) &&
          widget.tripsData[i].endDt.isBefore(DateTime.now())) {
        widget.tripsData[i].status = "past";
        pastTrips.add(widget.tripsData[i]);
      } else if (widget.tripsData[i].startDt.isBefore(DateTime.now()) &&
          widget.tripsData[i].endDt.isAfter(DateTime.now())) {
        widget.tripsData[i].status = "progress";
        progressTrips.add(widget.tripsData[i]);
      } else if (widget.tripsData[i].startDt.isAfter(DateTime.now()) &&
          widget.tripsData[i].endDt.isAfter(DateTime.now())) {
        widget.tripsData[i].status = "upcoming";
        upcomingTrips.add(widget.tripsData[i]);
      }
      print(widget.tripsData[i].tripTitle);
      print(widget.tripsData[i].status);
    }

    print(upcomingTrips.length);

    print(progressTrips.length);
    print(pastTrips.length);
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
              itemCount: progressTrips.length,
            ),
          ),
          Container(
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) =>
                  buildUpcomingList(ctxt, index),
              itemCount: upcomingTrips.length,
            ),
          ),
          Container(
              child: ListView.builder(
            itemBuilder: (BuildContext ctxt, int index) =>
                buildPastList(ctxt, index),
            itemCount: pastTrips.length,
          )),
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _navigateCreateTrip();
          },
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
    String formattedDate =
        DateFormat('dd MMM').format(progressTrips[index].startDt);
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
                  Text(formattedDate,
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
              "${progressTrips[index].tripTitle}",
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
                    Text(
                      progressTrips[index].tripDetail,
                      style: TextStyle(
                          color: key.currentState.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black54),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    memberList(context, progressTrips[index].owner,
                        progressTrips[index].members),
                  ],
                ),
              ]),
          onTap: () {
            int newIndex = widget.tripsData.indexOf(progressTrips[index]);
            print("new Index " + newIndex.toString());
            _navigateTripDetails(newIndex);
          },
        ),
        secondaryActions: <Widget>[
          buildIconSlideAction(
              "More", Colors.grey, Icons.more_horiz, index, progressTrips),
          buildIconSlideAction(
              "Delete", Colors.red, Icons.delete, index, progressTrips),
        ],
      ),
    );
  }

  Card buildUpcomingList(BuildContext ctxt, int index) {
    String formattedDate =
        DateFormat('dd MMM').format(upcomingTrips[index].startDt);
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
                  Text(formattedDate,
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
              "${upcomingTrips[index].tripTitle}",
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
                    Text(
                      upcomingTrips[index].tripDetail,
                      style: TextStyle(
                          color: key.currentState.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black54),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    memberList(context, upcomingTrips[index].owner,
                        upcomingTrips[index].members),
                  ],
                ),
              ]),
          onTap: () {
            int newIndex = widget.tripsData.indexOf(upcomingTrips[index]);
            print("new Index " + newIndex.toString());
            _navigateTripDetails(newIndex);
          },
        ),
        secondaryActions: <Widget>[
          buildIconSlideAction(
              "More", Colors.grey, Icons.more_horiz, index, upcomingTrips),
          buildIconSlideAction(
              "Delete", Colors.red, Icons.delete, index, upcomingTrips),
        ],
      ),
    );
  }

  Card buildPastList(BuildContext ctxt, int index) {
    String formattedDate =
        DateFormat('dd MMM').format(pastTrips[index].startDt);
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
                  Text(formattedDate,
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
              "${pastTrips[index].tripTitle}",
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
                    Text(
                      pastTrips[index].tripDetail,
                      style: TextStyle(
                          color: key.currentState.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black54),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    memberList(context, pastTrips[index].owner,
                        pastTrips[index].members),
                  ],
                ),
              ]),
          onTap: () {
            int newIndex = widget.tripsData.indexOf(pastTrips[index]);
            print("new Index " + newIndex.toString());
            _navigateTripDetails(newIndex);
          },
        ),
        secondaryActions: <Widget>[
          buildIconSlideAction(
              "More", Colors.grey, Icons.more_horiz, index, upcomingTrips),
          buildIconSlideAction(
              "Delete", Colors.red, Icons.delete, index, upcomingTrips),
        ],
      ),
    );
  }

  IconSlideAction buildIconSlideAction(String caption, Color colors,
      IconData icons, int index, List<Trips> trips) {
    return IconSlideAction(
      caption: caption,
      color: colors,
      icon: icons,
      onTap: () {
        if (caption == "Delete") {
          int newIndex = widget.tripsData.indexOf(trips[index]);
          _deleteConfirmation(context, newIndex);
        }
      },
    );
  }

  Container memberList(BuildContext context, User user, List<User> friendUser) {
    List<User> memberList = [];
    memberList.clear();
    memberList.add(user);
    memberList.addAll(friendUser);
    return Container(
      height: 48.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
        scrollDirection: Axis.horizontal,
        itemCount: friendUser.length + 1,
        itemBuilder: (context, index) {
          return buildMemberAvatar(index, memberList, context);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 5.0,
        ),
      ),
    );
  }

  ClipOval buildMemberAvatar(
      int index, List<User> memberList, BuildContext context) {
    return ClipOval(
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/loading.gif",
        image: memberList[index].profilePic,
        fit: BoxFit.contain,
        width: 30.0,
        height: 30.0,
      ),
    );
  }

  Future _deleteConfirmation(BuildContext context, int index) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Trip Confirmation'),
          content: const Text(
              'This will delete all the trip information from this application.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Confirm'),
              onPressed: () {
                setState(() {
                  widget.tripsData.removeWhere((item) =>
                      item.tripDetail == widget.tripsData[index].tripDetail);
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _tripAddedAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Trip Message'),
          content: const Text('The trip is added successfully.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
