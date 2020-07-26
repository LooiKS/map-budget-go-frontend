import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/schedule/schedule_detail_screen.dart';
import 'package:budgetgo/screen/schedule/schedule_form.dart';
import 'package:budgetgo/services/authentication_service.dart';
import 'package:budgetgo/services/schedule_data_service.dart';
import 'package:budgetgo/services/trip_data_service.dart';
import 'package:budgetgo/services/users_date_service.dart';
// import 'package:budgetgo/screen/trips/schedule_form.dart';
import 'package:budgetgo/utils/calendar.dart';
import 'package:budgetgo/widget/custom_shape.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  final Trips trip;
  final List<Schedule> schedules;
  ScheduleScreen(this.trip, this.schedules);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScheduleDataService scheduleDataService = ScheduleDataService();
  FirebaseUser fuser;
  User user;

  @override
  void initState() {
    Auth().getCurrentUser().then((firebaseUser) {
      fuser = firebaseUser;
      userDataService.getUser(id: fuser.uid).then((u) => user = u);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedules',
          style: TextStyle(color: Colors.white),
        ),
        shape: CustomShapeBorder(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _buildTitle(context),
            _buildMainList(),
          ],
        ),
      ),
    );
  }

  ListTile _buildTitle(BuildContext context) {
    return ListTile(
      title: Text(
        'Schedules',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduleForm(
                          widget.trip,
                          Schedule.empty(
                              user, widget.trip.startDt, widget.trip.startDt))))
              .then((newSchedule) {
            // if (newSchedule != null)
            // setState(() => widget.schedules.add(newSchedule));
          });
        },
      ),
    );
  }

  Expanded _buildMainList() {
    return Expanded(
      child: ListView.builder(
        // separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          elevation: 3,
          child: ListTile(
            title: Text(
              widget.schedules[index].activityTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.event,
                  color: Colors.orange,
                ),
                Text(
                    '${Month[widget.schedules[index].startDt.month]}, ${widget.schedules[index].startDt.day}')
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('${Month[widget.schedules[index].startDt.month]}, ${widget.schedules[index].startDt.day} ${widget.schedules[index].startDt.year} ' +
                  '${widget.schedules[index].startDt.hour.toString().padLeft(2, '0')}:${widget.schedules[index].startDt.minute.toString().padLeft(2, '0')}\n' +
                  '${Month[widget.schedules[index].endDt.month]}, ${widget.schedules[index].endDt.day} ${widget.schedules[index].endDt.year} ' +
                  '${widget.schedules[index].endDt.hour.toString().padLeft(2, '0')}:${widget.schedules[index].endDt.minute.toString().padLeft(2, '0')}'),
            ),
            contentPadding: EdgeInsets.all(8.0),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScheduleDetailScreen(
                        widget.trip, widget.schedules[index]))
                // .then((updatedSchedule) {
                // if (updatedSchedule != null)
                // setState(() => widget.schedules[index] = updatedSchedule);
                // }
                ),
            onLongPress: () => widget.schedules[index].createdBy.id == user.id
                ? showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Delete'),
                          content: Text(
                              'Are you sure to delete the schedule ${widget.schedules[index].activityTitle}?'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child:
                                                              CircularProgressIndicator()),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Loading...',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                  scheduleDataService.deleteSchedule(
                                      widget.schedules[index].id);
                                  widget.trip.schedules.removeWhere((s) =>
                                      s.id == widget.schedules[index].id);
                                  TripDataService()
                                      .updateTrip(widget.trip.id, widget.trip);
                                  setState(() {});
                                  print('doneeeee');
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'))
                          ],
                        ))
                : null,
          ),
        ),
        itemCount: widget.schedules.length,
      ),
    );
  }
}
