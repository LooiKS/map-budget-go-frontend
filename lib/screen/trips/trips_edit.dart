import 'package:budgetgo/constant/currency.dart';
import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/home_page/home_page.dart';
import 'package:budgetgo/screen/trips/add_members.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../../widget/custom_shape.dart';
import 'delete_members.dart';

class TripsEdit extends StatefulWidget {
  Trips _tripData;

  TripsEdit(this._tripData);
  @override
  _TripsEditState createState() => _TripsEditState();
}

class _TripsEditState extends State<TripsEdit> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final dateInputFormat = DateFormat("dd-MM-yyyy");
  List<User> memberList = [];
  List<User> tempUsers = [];
  List<Trips> dummyTrip = <Trips>[];
  List<TripExpenses> dummyExpenses = <TripExpenses>[];
  bool _enabledEdit = false;
  TextEditingController _tripTitle;
  TextEditingController _tripDetail;
  TextEditingController _startDate;
  TextEditingController _endDate;
  String _inputCurrency;

  @override
  void initState() {
    _startDate = TextEditingController(
        text: widget._tripData.startDt.toString().substring(0, 10));
    _endDate = TextEditingController(
        text: widget._tripData.endDt.toString().substring(0, 10));
    _tripTitle = TextEditingController(text: widget._tripData.tripTitle);
    _tripDetail = TextEditingController(text: widget._tripData.tripDetail);
    _inputCurrency = widget._tripData.currency;
    super.initState();
  }

  void _navigateAddFriend() async {
    final returnData = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddMember(Trips.copy(widget._tripData))),
    );

    if (returnData != null) {
      setState(() {
        widget._tripData = returnData;
        memberList.clear();
      });
    }
  }

  void _navigateDelFriend() async {
    final returnData = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DelMembers(Trips.copy(widget._tripData))),
    );

    if (returnData != null) {
      setState(() {
        widget._tripData = returnData;
        memberList.clear();
      });
    }
  }

  void _saveEdit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _enabledEdit = false;
        widget._tripData.tripTitle = _tripTitle.text;
        widget._tripData.tripDetail = _tripDetail.text;
        widget._tripData.currency = _inputCurrency;
      });
      if (DateTime.parse(_startDate.text.substring(0, 10))
              .isBefore(DateTime.parse(_endDate.text.substring(0, 10))) ==
          true) {
        setState(() {
          widget._tripData.startDt =
              DateTime.parse(_startDate.text.substring(0, 10));
          widget._tripData.endDt =
              DateTime.parse(_endDate.text.substring(0, 10));
        });
        _tripEdittedAlert(context);
      } else {
        _dateErrorAlert(context);
      }
    }
  }

  void _cancelEdit() {
    setState(() {
      _enabledEdit = false;
      _tripTitle.text = widget._tripData.tripTitle;
      _tripDetail.text = widget._tripData.tripDetail;
      _startDate.text = widget._tripData.startDt.toString().substring(0, 10);
      _endDate.text = widget._tripData.endDt.toString().substring(0, 10);
      _inputCurrency = widget._tripData.currency;
    });
  }

  Future _deleteConfirmationAlert(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Trip Confirmation'),
          content: const Text(
              'This will delete all the trip information from this application.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Confirm'),
              onPressed: () {
                setState(() {
                  for (int i = 0; i < mockdata.length; i++) {
                    if (mockdata[i].tripID == widget._tripData.tripID &&
                        mockdata[i].owner == widget._tripData.owner) {
                      mockdata.remove(mockdata[i]);
                    }
                  }
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                      (_) => true);
                });
              },
            )
          ],
        );
      },
    );
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

  Future<void> _tripEdittedAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Trip Message'),
          content: const Text('The trip is editted successfully.'),
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

  Future _requestPopMessage(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Discard your changes?'),
          content:
              const Text('If you go back now, your change will be discarded.'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'KEEP',
                style: TextStyle(
                    color: key.currentState.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 15.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(
                'DISCARD',
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(null);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_enabledEdit == true) {
          _requestPopMessage(context);
        } else {
          Navigator.of(context).pop(widget._tripData);
        }
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Trip Info",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              if (_enabledEdit == true) {
                _requestPopMessage(context);
              } else {
                Navigator.of(context).pop(widget._tripData);
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
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
              buildDeleteButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Container buildDeleteButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: RaisedButton(
        color: Colors.redAccent,
        elevation: 5.0,
        onPressed: () => _deleteConfirmationAlert(context),
        child:
            //Check is owner or not
            widget._tripData.owner.id == "01"
                ? Text(
                    "EXIT AND DELETE TRIP",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                : Text(
                    "EXIT TRIP",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
            if (title == "Trip Information")
              title == "Trip Information" && _enabledEdit == false
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _enabledEdit = !_enabledEdit;
                        });
                      },
                    )
                  : Row(children: <Widget>[
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.clear),
                        onPressed: () => _cancelEdit(),
                      ),
                      IconButton(
                        color: Colors.green,
                        icon: Icon(Icons.done),
                        onPressed: () {
                          _saveEdit();
                        },
                      ),
                    ])
            else
              Text("")
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
        itemCount: memberList.length + 2,
      ),
    );
  }

  GestureDetector buildMemberAvatar(
      int index, List<User> userList, User user, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          index < memberList.length
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
                    index == memberList.length
                        ? _navigateAddFriend()
                        : _navigateDelFriend();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.grey),
                    ),
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                          index == memberList.length ? Icons.add : Icons.remove,
                          size: 30.0,
                          color: Colors.grey),
                    ),
                  ),
                ),
          const SizedBox(height: 5.0),
          if (index < memberList.length)
            Text(
              memberList[index].lastName,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          else
            Text(
              index == memberList.length ? "Add" : "Delete",
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
    return Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _tripTitle,
                enabled: _enabledEdit,
                decoration: InputDecoration(labelText: "Trip Title "),
                validator: (value) {
                  if (value.isEmpty) {
                    return "This input field shouldn't be empty.";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    _tripTitle.text = value;
                  });
                  _tripTitle.text = value;
                },
              ),
              TextFormField(
                enabled: _enabledEdit,
                controller: _tripDetail,
                decoration: InputDecoration(
                  labelText: "Trip Detail ",
                ),
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
                      initialValue: DateTime.parse(_startDate.text),
                      decoration: InputDecoration(
                          labelText: 'Start Date',
                          hintText: ('dd-mm-yyyy'),
                          enabled: _enabledEdit),
                      onShowPicker: (context, _dateStart) {
                        return showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(_startDate.text),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                      },
                      readOnly: true,
                      enabled: false,
                    )
                  : DateTimeField(
                      enabled: _enabledEdit,
                      format: dateInputFormat,
                      initialValue: DateTime.parse(_startDate.text),
                      decoration: InputDecoration(
                          labelText: 'Start Date',
                          hintText: ('yyyy-mm-dd'),
                          enabled: _enabledEdit),
                      onShowPicker: (context, pickedDate) {
                        return showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.parse(_startDate.text) ?? DateTime.now(),
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
                      controller: _startDate,
                      onSaved: (value) {
                        setState(() {
                          if (value != null) {
                            _startDate.text = value.toString().substring(0, 10);
                          }
                        });
                      },
                    ),
              widget._tripData.status == "progress"
                  ? DateTimeField(
                      format: dateInputFormat,
                      initialValue: DateTime.parse(_endDate.text),
                      decoration: InputDecoration(
                          labelText: 'End Date', hintText: ('dd-mm-yyyy')),
                      onShowPicker: (context, _dateEnd) {
                        return showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(_endDate.text),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                      },
                      readOnly: true,
                      enabled: false,
                    )
                  : DateTimeField(
                      enabled: _enabledEdit,
                      format: dateInputFormat,
                      initialValue: DateTime.parse(_endDate.text),
                      decoration: InputDecoration(
                          labelText: 'End Date',
                          hintText: ('dd-mm-yyyy'),
                          enabled: _enabledEdit),
                      onShowPicker: (context, _dateEnd) {
                        return showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(_endDate.text),
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
                      controller: _endDate,
                      onSaved: (value) {
                        setState(() {
                          if (value != null) {
                            _endDate.text = value.toString().substring(0, 10);
                          }
                        });
                      },
                    ),
              DropdownButtonFormField<String>(
                items: currency.map((String cur) {
                  return DropdownMenuItem<String>(
                    value: cur,
                    child: Text(cur),
                  );
                }).toList(),
                value: _inputCurrency,
                hint: Text(_inputCurrency),
                decoration: InputDecoration(
                    labelText: 'Currency',
                    contentPadding: const EdgeInsets.fromLTRB(0, 13, 0, 0)),
                elevation: 16,
                validator: (value) {
                  if (value == null) {
                    return "This input field shouldn't be empty.";
                  } else {
                    return null;
                  }
                },
                onChanged: _enabledEdit
                    ? (value) {
                        setState(() {
                          _inputCurrency = value;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ));
  }
}
