import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_create.dart';
import 'package:budgetgo/services/users_date_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import './trips_detail.dart';
import '../../main.dart';
import '../../services/trip_data_service.dart';

class TripsMainPage extends StatefulWidget {
  User user;

  TripsMainPage({this.user});
  @override
  _TripsMainPageState createState() => _TripsMainPageState();
}

class _TripsMainPageState extends State<TripsMainPage> {
  Future<List<Trips>> tripsFuture;
  List<Trips> _trips = [];
  List<Trips> _tempTrips = [];
  //String _tempUser = "BG0011";
  final dataService = TripDataService();
  List<Trips> progressTrips = [];
  List<Trips> upcomingTrips = [];
  List<Trips> pastTrips = [];

  void _navigateTripDetails(int index) async {
    //Trips returnData = await
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripsDetail(_trips[index]),
      ),
    );
    // if (returnData != null) {
    //   setState(() => _trips[index] = returnData);
    //   setState(() {
    //     _trips.removeWhere((item) => item.tripDetail == 'cancel');
    //   });

    // } else {}
  }

  void _navigateCreateTrip() async {
    final returnData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TripsCreatePage(ownerUser: widget.user)));
    if (returnData != null) {
      setState(() {
        _tripAddedAlert(context);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    tripsFuture = dataService.getAllTrips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Trips>>(
        future: tripsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _tempTrips = snapshot.data;
            _trips.clear();
            for (int j = 0; j < _tempTrips.length; j++) {
              if ((_tempTrips[j]
                      .members
                      .any((user) => user.id == widget.user.id)) ||
                  _tempTrips[j].owner.id == widget.user.id) {
                _trips.add(_tempTrips[j]);
              }
            }
            return buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching data... Please wait'),
          ],
        ),
      ),
    );
  }

  Widget buildMainScreen() {
    progressTrips.clear();
    upcomingTrips.clear();
    pastTrips.clear();
    for (int i = 0; i < _trips.length; i++) {
      if (_trips[i].startDt.isBefore(DateTime.now()) &&
          _trips[i].endDt.isBefore(DateTime.now())) {
        _trips[i].status = "past";
        pastTrips.add(_trips[i]);
      } else if (_trips[i].startDt.isBefore(DateTime.now()) &&
          _trips[i].endDt.isAfter(DateTime.now())) {
        _trips[i].status = "progress";
        progressTrips.add(_trips[i]);
      } else if (_trips[i].startDt.isAfter(DateTime.now()) &&
          _trips[i].endDt.isAfter(DateTime.now())) {
        _trips[i].status = "upcoming";
        upcomingTrips.add(_trips[i]);
      }
    }

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
            int newIndex = _trips.indexOf(progressTrips[index]);
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
            width: 65.0,
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
            int newIndex = _trips.indexOf(upcomingTrips[index]);
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
            int newIndex = _trips.indexOf(pastTrips[index]);
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
          int newIndex = _trips.indexOf(trips[index]);
          //String newID = trips[index].trip;
          _deleteConfirmation(context, trips[index].id, newIndex);
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
      child: memberList[index].profilePic == null
          ? Image.asset('assets\images\default_profile.png')
          : FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: memberList[index].profilePic,
              fit: BoxFit.contain,
              width: 30.0,
              height: 30.0,
            ),
    );
  }

  Future _deleteConfirmation(
      BuildContext context, String index, int tripsIndex) {
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
                  dataService.deleteTrip(index);
                  Navigator.of(context).pop();
                });
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
