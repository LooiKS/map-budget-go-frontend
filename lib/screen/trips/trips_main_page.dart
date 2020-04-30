import 'package:budgetgo/model/mock_data.dart';
import 'package:budgetgo/model/trip.dart';
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
 void _navigateTripDetails(int index) async {
    Trips returnData = await Navigator.push( 
      context,
      MaterialPageRoute(builder: (context) => TripsDetail(Trips.copy(widget.tripsData[index])),
    ),);
    if (returnData != null){
      setState(() => widget.tripsData[index] = returnData);
      setState(() {
        widget.tripsData.removeWhere((item) => item.tripName == 'cancel');
      });
    }
    else {}
  }
  void _navigateCreateTrip() async{
    Trips returnData = await Navigator.push(context,
    MaterialPageRoute(builder: (context) => TripsCreatePage()));
    if (returnData !=null){
      print(returnData.currency);
      setState(() {
        widget.tripsData.add(returnData);
      });
    }
  }
  // List<String> dummyTrips = ["Trip To Bali", "Trip to Sky"];
  // List<String> dummyLocation = ["Bali, Indonesia", "Genting, Malaysia"];

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
              itemCount: tripMockData.length,
            ),
          ),
          Container(child: Text("Coming Soon")),
          Container(child: Text("Past")),
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
    String formattedDate = DateFormat('dd MMM').format(widget.tripsData[index].startDate);
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
              "${widget.tripsData[index].tripName}",
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
                      widget.tripsData[index].location,
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
                    memberList(context,widget.tripsData[index].ownerUser,widget.tripsData[index].memberUser),
                    // CircleAvatar(
                    //     radius: 15.0,
                    //     child: Icon(Icons.more_horiz),
                    //     backgroundColor:
                    //         key.currentState.brightness == Brightness.dark
                    //             ? Colors.white
                    //             : Colors.black54),
                  ],
                ),
              ]),
          onTap: () {
            _navigateTripDetails(index);
            
          },
        ),
        secondaryActions: <Widget>[
          buildIconSlideAction("More", Colors.grey, Icons.more_horiz,index),
          buildIconSlideAction("Delete", Colors.red, Icons.delete,index),
        ],
      ),
    );
  }

  IconSlideAction buildIconSlideAction(
      String caption, Color colors, IconData icons,int index) {
    return IconSlideAction(
      caption: caption,
      color: colors,
      icon: icons,
      onTap: () {
        if (caption=="Delete"){
          setState(() {
            widget.tripsData.removeWhere((item) => item.tripName == widget.tripsData[index].tripName);
          });
        }
      },
    );
  }
Container memberList(BuildContext context,Users user, List<Users> friendUser) {
     List<Users> memberList = [];
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
          return buildMemberAvatar(index,memberList,context);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 5.0,
        ),
      ),
    );
  }

   ClipOval buildMemberAvatar(int index,List<Users> memberList,BuildContext context) {
     return ClipOval(
       child: FadeInImage.assetNetwork(
         placeholder: "assets/images/loading.gif",
         image: memberList[index].imageURL,
         fit: BoxFit.contain,
         width: 30.0,
         height: 30.0,
       ),
     );
   }
}
