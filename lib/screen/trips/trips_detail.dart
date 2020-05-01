import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/expenses/expenses_details.dart';
import 'package:budgetgo/screen/expenses/expenses_screen.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_shape.dart';
import './trips_member_list.dart';
import '../../main.dart';

class TripsDetail extends StatefulWidget {
  final Trips trip;
  TripsDetail(this.trip);
  @override
  _TripsDetailState createState() => _TripsDetailState();
}

class _TripsDetailState extends State<TripsDetail> {
  List<Trips> dummyTrip = <Trips>[];
  List<TripExpenses> dummyExpenses = <TripExpenses>[];

  @override
  Widget build(BuildContext context) {
    // dummyTrip.add(Trips("KumKoiKum", "Going to beach.", , _members, _startDt, _endDt, _schedules, _expenses, _createdDt, _currency));
    // dummyTrip.add(Trips("SuiMakMak", "Going to shopping."));

    // dummyExpenses.add(TripExpenses(
    //     "Hotel",
    //     DateTime(2020),
    //     200.0,
    //     User("_id", "_firstName", "_lastName", "_phoneNum", "_email",
    //         "_profilePic", "_username")));
    // dummyExpenses.add(TripExpenses(
    //     "Hotel",
    //     DateTime(2020),
    //     200.0,
    //     User("_id", "_firstName", "_lastName", "_phoneNum", "_email",
    //         "_profilePic", "_username")));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trip to ${widget.trip.tripTitle}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCategoryTitle("Members"),
            TripMemberList(),
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
                                  widget.trip.expenses,
                                  widget.trip.members,
                                  widget.trip.owner,
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
              widget.trip.schedules[index].activityTitle,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87),
            ),
            subtitle: Text(
              // mockdata[0].schedules[index].activityDesc,
              widget.trip.schedules[index].activityDesc,
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
        itemCount: widget.trip.schedules.length,
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
                child: buildExpensesIcon(widget.trip.expenses[index].category)),
            trailing: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpenseDetailsScreen(widget.trip.expenses[index])));
              },
            ),
            title: Text(
              widget.trip.expenses[index].title,
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
                    "Paid by ${widget.trip.expenses[index].payBy.firstName}",
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                  Text(
                    widget.trip.expenses[index].createdDt.toString(),
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                  Text(
                    widget.trip.expenses[index].amount.toString(),
                    style: TextStyle(
                        color: key.currentState.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54),
                  ),
                ]),
          ),
        ),
        itemCount: widget.trip.expenses.length,
      ),
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
