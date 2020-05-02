import 'package:budgetgo/constant/currency.dart';
import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widget/custom_shape.dart';

class TripsCreatePage extends StatefulWidget {
  @override
  _TripsCreateState createState() => _TripsCreateState();
}

class _TripsCreateState extends State<TripsCreatePage> {
  String _inputCurrency;
  String holder;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New Trip",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // buildCategoryTitle("Members"),
            // tripMemberList(
            //     widget._tripData.memberUser, widget._tripData.ownerUser),
            SizedBox(height: 10.0),
            buildCategoryTitle("Trip Information"),
            buildTripForm(),
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
          ]),
    );
  }

  Container buildTripForm() {
    DateTime _dateStart;
    DateTime _dateEnd;

    TextEditingController _tripTitle = TextEditingController();
    TextEditingController _tripDetail = TextEditingController();
    final dateInputFormat = DateFormat("dd-MM-yyyy");

    return Container(
        padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Trip Title "),
                validator: (value) {
                  if (value.isEmpty) {
                    return "This input field shouldn't be empty.";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _tripTitle.text = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Trip Detail "),
                validator: (value) {
                  if (value.isEmpty) {
                    return "This input field shouldn't be empty.";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _tripDetail.text = value;
                },
              ),
              DateTimeField(
                format: dateInputFormat,
                decoration: InputDecoration(
                    labelText: 'Start Date', hintText: ('dd-mm-yyyy')),
                onShowPicker: (context, _dateStart) {
                  return showDatePicker(
                    context: context,
                    initialDate: _dateStart ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                },
                validator: (value) {
                  if (value == null) {
                    return "This input field shouldn't be empty.";
                  } else if (value.isBefore(DateTime.now())) {
                    return "The date selected shouldn't be earlier than today";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    if (value != null) {
                      _dateStart = value;
                    }
                  });
                },
              ),
              DateTimeField(
                format: dateInputFormat,
                //controller: _endDate,
                decoration: InputDecoration(
                    labelText: 'End Date', hintText: ('dd-mm-yyyy')),
                onShowPicker: (context, _dateEnd) {
                  return showDatePicker(
                    context: context,
                    initialDate: _dateEnd ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                },
                validator: (value) {
                  if (value == null) {
                    return "This input field shouldn't be empty.";
                  } else if (value.isBefore(DateTime.now())) {
                    return "The date selected shouldn't be earlier than today";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    if (value != null) {
                      _dateEnd = value;
                    }
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: "Currency",
                    contentPadding: const EdgeInsets.fromLTRB(0, 13, 0, 0)),
                items: currency.map((value) {
                  return DropdownMenuItem<String>(
                      child: Text(value), value: value);
                }).toList(),
                value: _inputCurrency,
                validator: (value) {
                  if (value == null) {
                    return "This input field shouldn't be empty.";
                  } else {
                    return null;
                  }
                },
                onChanged: (newValue) {
                  setState(() {
                    _inputCurrency = newValue;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (_dateStart.isBefore(_dateEnd) == true) {
                          setState(() {
                            _formKey.currentState.save();
                            Trips _newTrip = new Trips(
                                _tripTitle.text,
                                _tripDetail.text,
                                mockOwnUser,
                                [],
                                _dateStart,
                                _dateEnd,
                                [],
                                [],
                                DateTime.now(),
                                _inputCurrency,
                                "upcoming");
                            Navigator.pop(context, _newTrip);
                          });
                        } else {
                          _dateErrorAlert(context);
                        }
                      }
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future<void> _dateErrorAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Date Error'),
          content: const Text(
              'The Start Date should not be earlier than End Date. Please make the changes.'),
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
}
