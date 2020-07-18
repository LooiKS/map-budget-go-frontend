import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/services/schedule_data_service.dart';
import 'package:budgetgo/utils/calendar.dart';
import 'package:budgetgo/widget/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ScheduleForm extends StatefulWidget {
  final Schedule schedule;

  ScheduleForm(this.schedule);

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  DateTime startDate, startTime;
  DateTime endDate, endTime;
  Schedule schedule;

  @override
  void initState() {
    super.initState();
    schedule = Schedule.copy(widget.schedule);
    startDate = startTime = schedule.startDt;
    endDate = endTime = schedule.endDt;
  }

  @override
  Widget build(BuildContext context) {
    print(schedule.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          schedule.activityTitle.isEmpty ? 'New Schedule' : 'Edit Schedule',
          style: TextStyle(color: Colors.white),
        ),
        shape: CustomShapeBorder(),
        leading: IconButton(onPressed: _onBack, icon: Icon(Icons.arrow_back)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FlatButton(
                onPressed: _onSave,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildStartCard(),
              _buildEndCard(),
              _buildDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildDetailsCard() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCardTitle('Details'),
          ListTile(
            leading: Icon(
              Icons.local_activity,
              color: Colors.blue,
            ),
            title: Text('Activity'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: TextField(
              controller: TextEditingController()
                ..text = schedule.activityTitle,
              textAlign: TextAlign.center,
              onChanged: (value) => schedule.activityTitle = value,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.description,
              color: Colors.blue,
            ),
            title: Text('Activity Description'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
            child: TextField(
              controller: TextEditingController()
                ..text = schedule.activityDesc.toString(),
              onChanged: (value) => schedule.activityDesc = value,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text('Created By'),
            trailing: Text(schedule.createdBy.firstName),
          ),
          ListTile(
            leading: Icon(
              Icons.date_range,
              color: Colors.blue,
            ),
            title: Text('Created On'),
            trailing: Text(
                '${Month[schedule.createdDt.month]} ${schedule.createdDt.day}, ${schedule.createdDt.year} ${schedule.createdDt.hour.toString().padLeft(2, '0')}:${schedule.createdDt.minute.toString().padLeft(2, '0')}:${schedule.endDt.second.toString().padLeft(2, '0')}'),
          ),
        ],
      ),
    );
  }

  Card _buildEndCard() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCardTitle('End'),
          _buildDateTimeTile(
              schedule.endDt,
              'End Date',
              Icons.calendar_today,
              (date) => setState(() => schedule.endDt = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  schedule.endDt.hour,
                  schedule.endDt.minute,
                  schedule.endDt.second))),
          _buildDateTimeTile(
              schedule.endDt,
              'End Time',
              Icons.access_time,
              (date) => setState(() => schedule.endDt = DateTime(
                  schedule.endDt.year,
                  schedule.endDt.month,
                  schedule.endDt.day,
                  date.hour,
                  date.minute,
                  date.second))),
        ],
      ),
    );
  }

  Card _buildStartCard() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCardTitle('Start'),
          _buildDateTimeTile(
              schedule.startDt,
              'Start Date',
              Icons.calendar_today,
              (date) => setState(() => schedule.startDt = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  schedule.startDt.hour,
                  schedule.startDt.minute,
                  schedule.startDt.second))),
          _buildDateTimeTile(
              schedule.startDt,
              'Start Time',
              Icons.access_time,
              (date) => setState(() => schedule.startDt = DateTime(
                  schedule.startDt.year,
                  schedule.startDt.month,
                  schedule.startDt.day,
                  date.hour,
                  date.minute,
                  date.second))),
        ],
      ),
    );
  }

  ListTile _buildDateTimeTile(
      DateTime date, String title, IconData icon, Function func) {
    return ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        trailing: Text(icon == Icons.access_time
            ? '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}'
            : '${Month[date.month]} ${date.day}, ${date.year}'),
        onTap: () => icon == Icons.access_time
            ? DatePicker.showTimePicker(context,
                currentTime: date, onConfirm: func)
            : DatePicker.showDatePicker(context,
                currentTime: date, onConfirm: func));
  }

  Padding _buildCardTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  void _onSave() {
    String errorMsg = '';
    schedule.activityTitle = schedule.activityTitle.trim();
    schedule.activityDesc = schedule.activityDesc.trim();
    if (schedule.activityTitle.isEmpty || schedule.activityDesc.isEmpty)
      errorMsg = "Activity title and activity description cannot be empty";
    else if (schedule.startDt.add(Duration(seconds: 1)).isAfter(schedule.endDt))
      errorMsg =
          'Activity must end after start time. Please change the date or time.';
    if (errorMsg.isNotEmpty)
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Message'),
                content: Text(errorMsg),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  )
                ],
              ));
    else {
      widget.schedule.activityTitle = schedule.activityTitle;
      widget.schedule.activityDesc = schedule.activityDesc;
      widget.schedule.startDt = schedule.startDt;
      widget.schedule.endDt = schedule.endDt;
      ScheduleDataService().updateSchedule(widget.schedule.id, schedule);
      Navigator.pop(context, schedule);
    }
  }

  void _onBack() {
    if (!widget.schedule.equalTo(schedule))
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Message'),
                content: Text('Are you sure you want to quit without saving?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/scheduledetails'));
                    },
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
    else
      Navigator.pop(context);
  }
}
