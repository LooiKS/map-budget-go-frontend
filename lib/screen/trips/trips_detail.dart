import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_edit.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/screen/expenses/expenses_details.dart';
import 'package:budgetgo/screen/expenses/expenses_screen.dart';
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
      });
    }
  }

  void _navigateExpenses() async {
    Trips returnData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpensesScreen(
          widget.tripsData,
        ),
      ),
    );
    if (returnData != null) {
      setState(() {
        widget.tripsData = returnData;
      });
    }
  }

  void _navigateExpenseDetails(int index) async {
    TripExpenses returnData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailsScreen(
          widget.tripsData.expenses[index],
        ),
      ),
    );
    if (returnData != null) {
      setState(() {
        widget.tripsData.expenses[index] = returnData;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: key.currentState.brightness == Brightness.dark
          ? Colors.transparent
          : Color.fromRGBO(244, 244, 244, 5),
      appBar: AppBar(
        elevation: 0,
        shape: CustomShapeBorder(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, widget.tripsData),
        ),
        title: Text(
          widget.tripsData.tripTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              if (widget.tripsData.status == "past") {
                _tripEditError(context);
              } else {
                _navigateEditTrips();
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCategoryHeader("Members"),
            buildTripMemberList(
                context, widget.tripsData.owner, widget.tripsData.members),
            buildCategoryHeader("Schedule"),
            buildSchedules(),
            buildCategoryHeader("Expenses"),
            buildExpenses(),
          ],
        ),
      ),
    );
  }

  Padding buildCategoryHeader(String title) {
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
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                    onPressed: title != "Schedule"
                        ? () {
                            _navigateExpenses();
                          }
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScheduleScreen(widget.trip.schedules)));
                          })
                : Text(""),
          ]),
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
            title:
                buildItemTitle(widget.tripsData.schedules[index].activityTitle),
            subtitle: buildItemSubTitle(
              widget.tripsData.schedules[index].activityDesc,
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ScheduleDetailScreen(widget.trip.schedules[index]))),
          ),
        ),
        itemCount: widget.tripsData.schedules.length,
      ),
    );
  }

  Container buildExpenses() {
    return Container(
      height: 200.0,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.tripsData.expenses.length,
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
                      _navigateExpenseDetails(index);
                    },
                  ),
                  title: buildItemTitle(widget.tripsData.expenses[index].title),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildItemSubTitle(
                            "Paid by ${widget.tripsData.expenses[index].payBy.firstName}"),
                        buildItemSubTitle(widget
                            .tripsData.expenses[index].createdDt
                            .toString()),
                        buildItemSubTitle(
                            widget.tripsData.expenses[index].amount.toString()),
                      ]),
                ),
              )),
    );
  }

  Text buildItemTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: key.currentState.brightness == Brightness.dark
              ? Colors.white
              : Colors.black87),
    );
  }

  Text buildItemSubTitle(String subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          color: key.currentState.brightness == Brightness.dark
              ? Colors.white
              : Colors.black54),
    );
  }

  Icon buildExpensesIcon(String category) {
    switch (category) {
      case "Accommodation":
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
          Icons.local_play,
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

  Icon expensesLeadingIcon(IconData icon) {
    return Icon(
      icon,
      size: 38.0,
    );
  }
}
