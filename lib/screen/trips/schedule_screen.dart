import 'dart:async';

import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/utils/calendar.dart';
import 'package:budgetgo/widget/custom_shape.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('schedule'),
          shape: CustomShapeBorder(),
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
                          _buildFromToColumn(
                              'from', mockdata[0].schedules[0].startDt),
                          _buildFromToColumn(
                              'to', mockdata[0].schedules[0].endDt),
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
                                  text: mockdata[0].schedules[0].activityTitle),
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
                                    mockdata[0].schedules[0].activityDesc,
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
                                ScheduleStatus(),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        _buildCreatedByCreatedOnColumn(
                                            'Created By:',
                                            mockdata[0]
                                                .schedules[0]
                                                .createdBy
                                                .firstName),
                                        _buildCreatedByCreatedOnColumn(
                                          'Created on:',
                                          '${Month[mockdata[0].schedules[0].createdDt.month]} ${mockdata[0].schedules[0].createdDt.day.toString()}, ${mockdata[0].schedules[0].createdDt.year}',
                                        ),
                                      ]),
                                )
                              ])),
                      shape: RoundedRectangleBorder(),
                    )
                  ],
                ),
              )
              /*
               Column(
                 children: <Widget>[
                   ListTile(
                     leading: Icon(
                       Icons.calendar_today,
                       color: Colors.blue,
                     ),
                     title: Text('Start Date Time'),
                     trailing: Text(mockdata[0].schedules[0].startDt.toString()),
                   ),
                   ListTile(
                     leading: Icon(
                       Icons.calendar_today,
                       color: Colors.blue,
                     ),
                     title: Text('End Date Time'),
                     trailing: Text(mockdata[0].schedules[0].endDt.toString()),
                   ),
                   ListTile(
                     leading: Icon(
                       Icons.local_activity,
                       color: Colors.blue,
                     ),
                     title: Text('Activity'),
                     trailing: Text(mockdata[0].schedules[0].activityTitle),
                   ),
                   ListTile(
                     leading: Icon(
                       Icons.description,
                       color: Colors.blue,
                     ),
                     title: Text('Activity Description'),
                     trailing: Text(
                       mockdata[0].schedules[0].activityDesc.toString(),
                     ),
                   ),
                   ListTile(
                     leading: Icon(
                       Icons.person,
                       color: Colors.blue,
                     ),
                     title: Text('Created By'),
                     trailing: Text(mockdata[0].schedules[0].createdBy.firstName),
                   ),
                   ListTile(
                     leading: Icon(
                       Icons.date_range,
                       color: Colors.blue,
                     ),
                     title: Text('Created On'),
                     trailing: Text(mockdata[0].schedules[0].createdDt.toString()),
                   ),
                 ],
               ),*/
              ),
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
            '${time.hour.toString()}:${time.minute.toString().padLeft(2, '0')} ${time.hour > 11 ? "PM" : "AM"}',
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
  @override
  _ScheduleStatusState createState() => _ScheduleStatusState();
}

class _ScheduleStatusState extends State<ScheduleStatus> {
  var countDown = mockdata[0].schedules[0].startDt.difference(DateTime.now());
  var timeElapsed = DateTime.now().difference(mockdata[0].schedules[0].endDt);
  Timer timer;

  _ScheduleStatusState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countDown = mockdata[0].schedules[0].startDt.difference(DateTime.now());
        timeElapsed = DateTime.now().difference(mockdata[0].schedules[0].endDt);
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
