import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_edit.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/screen/expenses/expenses_details.dart';
import 'package:budgetgo/screen/expenses/expenses_screen.dart';
import 'package:budgetgo/screen/trips/add_members.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_shape.dart';
import '../../main.dart';

class TripsDetail extends StatefulWidget {
  Trips tripsData;
  TripsDetail(this.tripsData);
  @override
  _TripsDetailState createState() => _TripsDetailState();
}

class _TripsDetailState extends State<TripsDetail> {
  List<Trips> dummyTrip = <Trips>[];
  List<TripExpenses> dummyExpenses = <TripExpenses>[];
  List<String> tripsDetailSetting = ['Trip Info', 'Report', 'Exit Group'];

  void _navigateEditTrips() async {
    Trips returnData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripsEdit(widget.tripsData),
      ),
    );
    if (returnData != null) {
      setState(() {
        widget.tripsData = returnData;
        _tripEdittedAlert(context);
      });
    } else {}
  }

  void _selected(String route) {
    setState(() {
      if (route == tripsDetailSetting[0]) {
        if (widget.tripsData.status == "past") {
          _tripEditError(context);
        } else {
          _navigateEditTrips();
        }
      } else if (route == "Delete") {
        _deleteConfirmationAlert(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, widget.tripsData),
        ),
        title: Text(
          widget.tripsData.tripTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _selected,
            itemBuilder: (BuildContext context) {
              return tripsDetailSetting.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                  height: 65.0,
                );
              }).toList();
            },
          ),
        ],
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCategoryTitle("Members"),
            buildTripMemberList(context, widget.tripsData.owner,
                widget.tripsData.members), // Container(
            //   height: 80.0,
            //   child: ListView.builder(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: widget.tripsData.members.length,
            //     itemBuilder: (context, index) => Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: <Widget>[
            //         GestureDetector(
            //           onTap: () {},
            //           child: Column(
            //             children: <Widget>[
            //               ClipOval(
            //                 child: FadeInImage.assetNetwork(
            //                   placeholder: "assets/images/loading.gif",
            //                   image: widget.tripsData.members[index].profilePic,
            //                   fit: BoxFit.contain,
            //                   width: 45.0,
            //                   height: 45.0,
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 40,
            //                 child: Text(
            //                   widget.tripsData.members[index].lastName,
            //                   overflow: TextOverflow.ellipsis,
            //                   textAlign: TextAlign.center,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            buildCategoryTitle("Schedule"),
            buildSchedules(),
            buildCategoryTitle("Expenses"),
            buildExpenses(),
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
                ? FlatButton(
                    child: Text(
                      'View All',
                      // style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: title != "Schedule"
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExpensesScreen(
                                  widget.tripsData.expenses,
                                  widget.tripsData.members,
                                  widget.tripsData.owner,
                                ),
                              ),
                            );
                          }
                        : () {
                            Navigator.push(context, null);
                          })
                // ? Text("View All",
                //     style: TextStyle(
                //       fontSize: 15.0,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.orange,
                //     ))
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
              // mockdata[0].schedules[index].activityTitle,
              widget.tripsData.schedules[index].activityTitle,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87),
            ),
            subtitle: Text(
              // mockdata[0].schedules[index].activityDesc,
              widget.tripsData.schedules[index].activityDesc,
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
        itemCount: widget.tripsData.schedules.length,
      ),
    );
  }

  Container buildTripMemberList(
      BuildContext context, User user, List<User> friendUser) {
    List<User> memberList = [];
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
          return buildMemberAvatar(index, memberList);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }

  GestureDetector buildMemberAvatar(int index, List<User> memberList) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          ClipOval(
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: memberList[index].profilePic,
              fit: BoxFit.contain,
              width: 30.0,
              height: 30.0,
            ),
          ),
          const SizedBox(height: 5.0),
          SizedBox(
            width: 40.0,
            child: Text(
              memberList[index].firstName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
            leading: Container(
                width: 48.0,
                child: buildExpensesIcon(
                    widget.tripsData.expenses[index].category)),
            trailing: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpenseDetailsScreen(
                            widget.tripsData.expenses[index])));
              },
            ),
            title: Text(
              widget.tripsData.expenses[index].title,
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
                    "Paid by ${widget.tripsData.expenses[index].payBy.firstName}",
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                  Text(
                    widget.tripsData.expenses[index].createdDt.toString(),
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                  Text(
                    widget.tripsData.expenses[index].amount.toString(),
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                ]),
          ),
        ),
        itemCount: widget.tripsData.expenses.length,
      ),
    );
  }

  Future _deleteConfirmationAlert(BuildContext context) {
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
                  widget.tripsData.tripDetail = "cancel";
                  Navigator.of(context).pop();
                });
                Navigator.pop(context, widget.tripsData);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _tripEdittedAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Trip Message'),
          content: const Text('The trip is editted successfully.'),
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

  Future<void> _tripEditError(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Trip Message'),
          content: const Text(
              'The trip is already over. You cannot edit this trip anymore.'),
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
          Icons.airport_shuttle,
          size: 38.0,
        );
        break;

      case "Food & Beverage":
        return Icon(
          Icons.fastfood,
          size: 38.0,
        );
        break;

      case "Entertainment":
        return Icon(
          Icons.casino,
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
