import 'dart:async';

import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/screen/schedule/schedule_form.dart';
import 'package:budgetgo/screen/trips/trips_detail.dart';
import 'package:budgetgo/utils/calendar.dart';
import 'package:budgetgo/widget/custom_shape.dart';
import 'package:flutter/material.dart';

class ScheduleDetailScreen extends StatefulWidget {
  final Trips trip;
  final Schedule index;
  ScheduleDetailScreen(this.trip,this.index);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleDetailScreen> {
  Schedule schedule;
  @override
  initState() {
    super.initState();
    schedule = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Schedule',
            style: TextStyle(color: Colors.white),
          ),
          shape: CustomShapeBorder(),
          actions: (loggedInUser.id == schedule.createdBy.id)
              ? <Widget>[
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScheduleForm(widget.trip, widget.index)))
                              .then((newSchedule) {
                            // if (newSchedule != null)
                            // setState(() => widget.index.activityTitle = newSchedule);
                          }))
                ]
              : [],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 35.0, bottom: 8.0, left: 8.0, right: 8.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildFromToColumn('from', schedule.startDt),
                          _buildFromToColumn('to', schedule.endDt),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomPaint(
                        painter: CustomShape(),
                        child: Container(
                          width: 300,
                          margin: EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            controller: TextEditingController()
                              ..value = TextEditingValue(
                                  text: schedule.activityTitle),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 100.0),
                                    borderRadius: BorderRadius.circular(100))),
                            maxLines: null,
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                          width: MediaQuery.of(context).size.width - 10,
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black38),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                  ),
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 2.0),
                                  child: Text(
                                    schedule.activityDesc,
                                    style: TextStyle(),
                                  ),
                                ),
                                Text(
                                  'Status',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black38),
                                ),
                                ScheduleStatus(
                                    schedule.startDt, schedule.endDt),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        _buildCreatedByCreatedOnColumn(
                                            'Created By:',
                                            schedule.createdBy.firstName),
                                        _buildCreatedByCreatedOnColumn(
                                          'Created on:',
                                          '${Month[schedule.createdDt.month]} ${schedule.createdDt.day.toString()}, ${schedule.createdDt.year}',
                                        ),
                                      ]),
                                )
                              ])),
                      shape: RoundedRectangleBorder(),
                    )
                  ],
                ),
              )),
        ));
  }

  Column _buildCreatedByCreatedOnColumn(String title, String data) {
    return Column(
      children: <Widget>[
        Text(title),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Column _buildFromToColumn(String title, DateTime time) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.black54),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${(time.hour % 13).toString()}:${time.minute.toString().padLeft(2, '0')} ${time.hour > 11 ? "PM" : "AM"}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '${Month[time.month]} ${time.day.toString()}, ${time.year}',
        )
      ],
    );
  }
}

class ScheduleStatus extends StatefulWidget {
  final DateTime startDt, endDt;
  ScheduleStatus(this.startDt, this.endDt);
  @override
  _ScheduleStatusState createState() => _ScheduleStatusState();
}

class _ScheduleStatusState extends State<ScheduleStatus> {
  var countDown;
  var timeElapsed;
  Timer timer;

  _ScheduleStatusState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countDown = widget.startDt.difference(DateTime.now());
        timeElapsed = DateTime.now().difference(widget.endDt);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    countDown = widget.startDt.difference(DateTime.now());
    timeElapsed = DateTime.now().difference(widget.endDt);
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            child: Text(
              countDown.isNegative
                  ? timeElapsed.isNegative ? 'On Going' : 'Done'
                  : 'In Plan',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(countDown.isNegative
                ? timeElapsed.isNegative ? Icons.calendar_today : Icons.done
                : Icons.access_time),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                countDown.isNegative
                    ? timeElapsed.isNegative
                        ? 'Enjoy'
                        : 'Time Elapsed: ${timeElapsed.inDays.abs()} days ${(timeElapsed.inHours % 24).toString().padLeft(2, '0')}:${(timeElapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(timeElapsed.inSeconds % 60).toString().padLeft(2, '0')}'
                    : 'Start in ${countDown.inDays} days ${(countDown.inHours % 24).toString().padLeft(2, '0')}:${(countDown.inMinutes % 60).toString().padLeft(2, '0')}:${(countDown.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        )
      ],
    );
  }
}

class CustomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    paint.color = Colors.black54;
    paint.strokeWidth = 2.0;

    canvas.drawLine(Offset(size.width - 8, size.height / 2),
        Offset(size.width + 8, size.height / 2), paint);
    canvas.drawLine(
        Offset(8, size.height / 2), Offset(-8, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
