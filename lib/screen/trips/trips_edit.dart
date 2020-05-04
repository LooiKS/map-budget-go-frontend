import 'package:budgetgo/constant/currency.dart';
import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/add_members.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widget/custom_shape.dart';

class TripsEdit extends StatefulWidget {
  final Trips _tripData;

  TripsEdit(this._tripData);
  @override
  _TripsEditState createState() => _TripsEditState();
}

class _TripsEditState extends State<TripsEdit> {
  List<User> memberList = [];
  List<User> tempUsers = [];
  List<Trips> dummyTrip = <Trips>[];
  List<TripExpenses> dummyExpenses = <TripExpenses>[];
  String _inputCurrency;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateEditFriend() async {
    List<User> returnData = await Navigator.push(
      context,
      //Trips.copy(widget.tripsData[index])
      MaterialPageRoute(
          builder: (context) =>
              // AddMember(widget._tripData.members, widget._tripData.owner)),
              AddMember(Trips.copy(widget._tripData))),
    );
    if (returnData != null) {
      tempUsers.clear();
      for (int c = 0; c < returnData.length; c++) {
        if (returnData[c].isChecked == true) {
          tempUsers.add(returnData[c]);
        }
      }

      setState(() => widget._tripData.members = tempUsers);
      memberList.clear();
      memberList.add(widget._tripData.owner);
      memberList.addAll(widget._tripData.members);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Trip",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCategoryTitle("Members"),
            tripMemberList(widget._tripData.members, widget._tripData.owner),
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

  Widget tripMemberList(List<User> userList, User user) {
    if (memberList.isEmpty == true) {
      memberList.add(user);
      memberList.addAll(userList);
    }
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemBuilder: (context, index) =>
            buildMemberAvatar(index, userList, user, context),
        itemCount: memberList.length + 1,
      ),
    );
  }

  GestureDetector buildMemberAvatar(
      int index, List<User> userList, User user, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          index != memberList.length
              ? ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: memberList[index].profilePic,
                    fit: BoxFit.contain,
                    width: 30.0,
                    height: 30.0,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    _navigateEditFriend();
                  },
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      size: 30.0,
                      color: Colors.green,
                    ),
                  ),
                ),
          const SizedBox(height: 5.0),
          Text(
            index != memberList.length
                ? memberList[index].lastName
                : "Edit",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container buildTripForm() {
    DateTime _dateStart = widget._tripData.startDt;
    DateTime _dateEnd = widget._tripData.endDt;
    TextEditingController _tripTitle =
        TextEditingController(text: widget._tripData.tripTitle);
    TextEditingController _tripDetail =
        TextEditingController(text: widget._tripData.tripDetail);
    final dateInputFormat = DateFormat("dd-MM-yyyy");
    _inputCurrency = widget._tripData.currency;
    return Container(
        padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _tripTitle,
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
                controller: _tripDetail,
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
              widget._tripData.status == "progress"
                  ? DateTimeField(
                      format: dateInputFormat,
                      initialValue: _dateStart,
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
                      readOnly: true,
                      enabled: false,
                      onSaved: (value) {
                        setState(() {
                          if (value != null) {
                            _dateStart = value;
                          }
                        });
                      },
                    )
                  : DateTimeField(
                      format: dateInputFormat,
                      initialValue: _dateStart,
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
              widget._tripData.status == "progress"
                  ? DateTimeField(
                      format: dateInputFormat,
                      initialValue: _dateEnd,
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
                      readOnly: true,
                      enabled: false,
                      onSaved: (value) {
                        setState(() {
                          if (value != null) {
                            _dateEnd = value;
                          }
                        });
                      },
                    )
                  : DateTimeField(
                      format: dateInputFormat,
                      initialValue: _dateEnd,
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
                value: _inputCurrency,
                decoration: InputDecoration(
                    labelText: 'Currency',
                    hintText: ('Currency'),
                    contentPadding: const EdgeInsets.fromLTRB(0, 13, 0, 0)),
                elevation: 16,
                validator: (value) {
                  if (value == null) {
                    return "This input field shouldn't be empty.";
                  } else {
                    return null;
                  }
                },
                onChanged: (String value) {
                  setState(() {
                    widget._tripData.currency = value;
                    _inputCurrency = value;
                  });
                },
                items: currency.map((String cur) {
                  return DropdownMenuItem<String>(
                    value: cur,
                    child: Text(cur),
                  );
                }).toList(),
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
                            Trips _editTrip = new Trips(
                                _tripTitle.text,
                                _tripDetail.text,
                                mockOwnUser,
                                widget._tripData.members,
                                _dateStart,
                                _dateEnd,
                                [],
                                [],
                                DateTime.now(),
                                _inputCurrency,
                                widget._tripData.status);
                            Navigator.pop(context, _editTrip);
                          });
                        } else if (widget._tripData.status == "progress") {
                          print("safaaf");
                          Trips _editTrip = new Trips(
                              _tripTitle.text,
                              _tripDetail.text,
                              mockOwnUser,
                              widget._tripData.members,
                              _dateStart,
                              _dateEnd,
                              [],
                              [],
                              DateTime.now(),
                              _inputCurrency,
                              widget._tripData.status);
                          Navigator.pop(context, _editTrip);
                        } else {
                          _dateErrorAlert(context);
                        }
                      }
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Save'),
                  ),
                ],
              ),
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
