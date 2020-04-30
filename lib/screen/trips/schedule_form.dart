import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/utils/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ScheduleForm extends StatefulWidget {
  final Schedule schedule;
  // = Schedule;

  ScheduleForm(this.schedule); // {}

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  DateTime startDate, startTime;
  DateTime endDate, endTime;
  // _ScheduleFormState() {
  @override
  void initState() {
    super.initState();
    startDate = startTime = widget.schedule.startDt; //, startTime;
    endDate = endTime = widget.schedule.endDt; //, startTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                widget.schedule.startDt = DateTime(
                    startDate.year,
                    startDate.month,
                    startDate.day,
                    startTime.hour,
                    startTime.minute,
                    startTime.second);
                widget.schedule.endDt = DateTime(endDate.year, endDate.month,
                    endDate.day, endTime.hour, endTime.minute, endTime.second);
                Navigator.pop(context, widget.schedule);
              },
              child: Text('Save'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
                      child: Text(
                        'Start',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        title: Text('Start Date'),
                        trailing: Text(
                            '${Month[startDate.month]} ${startDate.day}, ${startDate.year}'),
                        onTap: () => DatePicker.showDatePicker(context,
                            currentTime: startDate,
                            onConfirm: ((date) =>
                                setState(() => startDate = date)))),
                    ListTile(
                        leading: Icon(
                          Icons.access_time,
                          color: Colors.blue,
                        ),
                        title: Text('Start Time'),
                        trailing: Text(
                            '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}:${startTime.second.toString().padLeft(2, '0')}'),
                        onTap: () => DatePicker.showTimePicker(context,
                            currentTime: startTime,
                            onConfirm: (date) =>
                                setState(() => startTime = date))),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
                      child: Text(
                        'End',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        title: Text('End Date'),
                        trailing: Text(
                            '${Month[endDate.month]} ${endDate.day}, ${endDate.year}'),
                        onTap: () => DatePicker.showDatePicker(context,
                            currentTime: endDate,
                            onConfirm: ((date) =>
                                setState(() => endDate = date)))),
                    ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        title: Text('End Time'),
                        trailing: Text(
                            '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}:${endTime.second.toString().padLeft(2, '0')}'),
                        onTap: () => DatePicker.showTimePicker(context,
                            currentTime: endTime,
                            onConfirm: (date) =>
                                setState(() => endTime = date))),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
                      child: Text(
                        'Details',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
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
                          ..text = widget.schedule.activityTitle,
                        textAlign: TextAlign.center,
                        onChanged: (value) =>
                            widget.schedule.activityTitle = value,
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
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, bottom: 10),
                      child: TextField(
                        controller: TextEditingController()
                          ..text = widget.schedule.activityDesc.toString(),
                        onChanged: (value) =>
                            widget.schedule.activityDesc = value,
                        // textAlign: TextAlign.center,
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
                      trailing: Text(widget.schedule.createdBy.firstName),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      title: Text('Created On'),
                      trailing: Text(
                          '${Month[widget.schedule.createdDt.month]} ${widget.schedule.createdDt.day}, ${widget.schedule.createdDt.year} ${widget.schedule.createdDt.hour.toString().padLeft(2, '0')}:${widget.schedule.createdDt.minute.toString().padLeft(2, '0')}:${widget.schedule.endDt.second.toString().padLeft(2, '0')}'), //widget.schedule.createdDt.toString()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
