import 'package:budgetgo/model/trip.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_edit.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_shape.dart';
import './trips_member_list.dart';
import '../../main.dart';

class TripsDetail extends StatefulWidget {
  Trips tripsData;
  TripsDetail(this.tripsData);
  @override
  _TripsDetailState createState() => _TripsDetailState();
}

class _TripsDetailState extends State<TripsDetail> {
 void _navigateEditTrips() async {
    Trips returnData = await Navigator.push( 
      context,
      MaterialPageRoute(builder: (context) => TripsEdit(Trips.copy(widget.tripsData)),
    ),);
    if (returnData != null){
      setState(() => widget.tripsData = returnData);
    }
    else {}
  }
    void _selected(String route) {
    setState(() {
      if (route == "Edit"){
        _navigateEditTrips();
      }
      else if (route == "Delete"){
        widget.tripsData.tripName = "cancel";
        Navigator.pop(context, widget.tripsData);
      }
    });
  } 
    List<String> operation = ["Edit","Delete"];
  // List<Trips> dummyTrip = <Trips>[];
  // List<TripExpenses> dummyExpenses = <TripExpenses>[];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(icon:Icon(Icons.arrow_back),
      onPressed:() => Navigator.pop(context, widget.tripsData),),
        title: Text(
          widget.tripsData.tripName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        shape: CustomShapeBorder(),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: _selected,
              itemBuilder: (BuildContext context) {
                return operation.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();

              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCategoryTitle("Members"),
            buildTripMemberList(context,widget.tripsData.ownerUser,widget.tripsData.memberUser),
            buildCategoryTitle("Schedule"),
          //  buildSchedules(),
            buildCategoryTitle("Expenses"),
           // buildExpenses(),
          ],
        ),
      ),
    );
  }

  Padding buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            title != "Members"
                ? Text("View All",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.orange,
                    ))
                : Text(""),
          ]),
    );
  }

  Container buildSchedules() {
    return Container(
      height: 200.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext ctxt, int index) => Card(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: ListTile(
            selected: true,
            leading: Container(
              width: 48.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 28.0,
                    ),
                    Text(
                      "Day ${index + 1}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30.0,
            ),
            title: Text(
              "safasf",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87),
            ),
            subtitle: Text(
             "asfasf",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                  color: key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black54),
            ),
            onTap: () {},
          ),
        ),
        //itemCount: dummyTrip.length,
      ),
    );
  }

  Container buildExpenses() {
    return Container(
      height: 200.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext ctxt, int index) => Card(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: ListTile(
            selected: true,
           // leading: Container(
             //   width: 48.0,
             //   child: buildExpensesIcon(dummyExpenses[index].title)),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30.0,
            ),
            title: Text(
              "asfasf",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87),
            ),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "safasf",
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                  Text(
                    "safasf",
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                  Text(
                    "asfasf",
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                ]),
            onTap: () {},
          ),
        ),
       // itemCount: "dummyExpenses.length",
      ),
    );
  }
  Widget buildTripMemberList(BuildContext context,Users user, List<Users> friendUser) {
    List<Users> memberList = [];
    memberList.clear();
    memberList.add(user);
    memberList.addAll(friendUser);
    return Container(
      height: 70.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: friendUser.length + 1,
        itemBuilder: (context, index) {
          return buildMemberAvatar(index,memberList);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }

  GestureDetector buildMemberAvatar(int index,List<Users> memberList) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
           ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: memberList[index].imageURL,
                    fit: BoxFit.contain,
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
            const SizedBox(height: 5.0),
          Text(
          memberList[index].userName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Icon buildExpensesIcon(String title) {
    switch (title) {
      case "Hotel":
        return Icon(
          Icons.hotel,
          size: 38.0,
        );
        break;

      case "Transport":
        return Icon(
          Icons.motorcycle,
          size: 38.0,
        );
        break;

      default:
        return Icon(
          Icons.attach_money,
          size: 38.0,
        );
        break;
    }
  }
}
