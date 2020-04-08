import 'package:flutter/material.dart';
import '../../widget/custom_shape.dart';
import './trips_member_list.dart';

class TripsDetail extends StatefulWidget {
  @override
  _TripsDetailState createState() => _TripsDetailState();
}

class _TripsDetailState extends State<TripsDetail> {
  List<String> planTitle = ["KumKoiKum", "SuiMakMak"];
  List<String> expensesTitle = ["Hotel", "Transport"];
  List<Icon> icons = [
    Icon(
      Icons.hotel,
      size: 38.0,
    ),
    Icon(
      Icons.motorcycle,
      size: 38.0,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trip To Bali",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildMemberTitle(),
            TripMemberList(),
            buildTitle("Schedule"),
            buildSchedules(),
            buildTitle("Expenses"),
            buildExpenses(),
          ],
        ),
      ),
    );
  }

  Padding buildMemberTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Text(
        "Members",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text("View All",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.orange,
                )),
          ]),
    );
  }

  Container buildSchedules() {
    return Container(
      height: 200.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext ctxt, int index) =>
            buildSchedulesCard(ctxt, index),
        itemCount: planTitle.length,
      ),
    );
  }

  Card buildSchedulesCard(BuildContext ctxt, int index) {
    return Card(
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
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
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
          planTitle[index],
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "10a.m. - Depart to ocean.",
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                "11a.m. - Eat beside ocean.",
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                "12p.m. - Sleep beside ocean.",
                style: TextStyle(color: Colors.black54),
              ),
            ]),
        onTap: () {},
      ),
    );
  }

  Container buildExpenses() {
    return Container(
      height: 200.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext ctxt, int index) =>
            buildExpensesCard(ctxt, index),
        itemCount: expensesTitle.length,
      ),
    );
  }

  Card buildExpensesCard(BuildContext ctxt, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      child: ListTile(
        selected: true,
        leading: Container(width: 48.0, child: icons[index]),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30.0,
        ),
        title: Text(
          expensesTitle[index],
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Paid by John",
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                "02-02-2020 10:20 a.m.",
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                "RM 200.00",
                style: TextStyle(color: Colors.black54),
              ),
            ]),
        onTap: () {},
      ),
    );
  }
}
