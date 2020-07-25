import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/services/trip_data_service.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../main.dart';

class DelMembers extends StatefulWidget {
  final Trips tripData;
  DelMembers(this.tripData);

  @override
  _DelMembersState createState() => _DelMembersState();
}

class _DelMembersState extends State<DelMembers> {
  final dataService = TripDataService();
  List<User> _memberList = [];
  List<User> _selectedMember = [];
  @override
  void initState() {
    _memberList.addAll(widget.tripData.members);

    for (User members in _memberList) {
      setState(() {
        members.isChecked = false;
      });
    }
    super.initState();
  }

  void filterSearchResults(String query) {
    List<User> dummySearchList = List<User>();
    dummySearchList.addAll(widget.tripData.owner.friend);
    if (query.isNotEmpty) {
      List<User> dummyListData = List<User>();
      dummySearchList.forEach((item) {
        if (item.username.contains(query)) {
          dummyListData.add(item);
        }
      });

      setState(() {
        _memberList.clear();
        _memberList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _memberList.clear();
        _memberList.addAll(widget.tripData.owner.friend);
      });
    }
  }

  void _delButton() {
    if (_selectedMember.length > 0) {
      setState(() {
        for (User member in _selectedMember) {
          widget.tripData.members.remove(member);
          dataService.updateTrip(widget.tripData.id, widget.tripData);
        }
      });
      Navigator.of(context).pop(widget.tripData);
    }
  }

  Future _confirmDeleteMesssage(BuildContext context) {
    if (_selectedMember.length > 0) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove Members?'),
            content:
                const Text('Are you confirm to remove the selected members?'),
            actions: <Widget>[
              cancelDeleteBtn(
                  context,
                  "CANCEL",
                  key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.grey),
              cancelDeleteBtn(context, "DELETE", Colors.red)
            ],
          );
        },
      );
    }
    return null;
  }

  FlatButton cancelDeleteBtn(BuildContext context, String title, Color color) {
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: 15.0),
      ),
      onPressed: () {
        if (title == "DELETE") {
          Navigator.of(context).pop();
          _delButton();
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  void _requestPopMessage(BuildContext context) async {
    if (_selectedMember.length > 0) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Discard your changes?'),
            content: const Text(
                'If you go back now, your change will be discarded.'),
            actions: <Widget>[
              keepOrDiscardBtn(
                context,
                "KEEP",
                key.currentState.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey,
              ),
              keepOrDiscardBtn(context, "DISCARD", Colors.blue)
            ],
          );
        },
      );
    } else {
      Navigator.pop(context, null);
    }
  }

  FlatButton keepOrDiscardBtn(BuildContext context, String title, Color color) {
    return FlatButton(
        child: Text(
          title,
          style: TextStyle(color: color, fontSize: 15.0),
        ),
        onPressed: title == "DISCARD"
            ? () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(null);
              }
            : () {
                Navigator.of(context).pop();
              });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _requestPopMessage(context);
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _requestPopMessage(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            "Remove Members",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[buildDeleteBtn(context)],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              buildSearchBar(context),
              if (_selectedMember.length > 0) buildSelectedMemberNo(),
              buildFriendList(),
              buildTotalMemberNo()
            ],
          ),
        ),
      ),
    );
  }

  Container buildDeleteBtn(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 23 / 100,
      padding: const EdgeInsets.only(right: 8.0, top: 13.0, bottom: 13.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        disabledColor: key.currentState.brightness == Brightness.dark
            ? Colors.grey
            : Colors.orangeAccent,
        color: Colors.red,
        onPressed: _selectedMember.length > 0
            ? () => _confirmDeleteMesssage(context)
            : null,
        child: Text(
          "Delete",
          style: _selectedMember.length > 0
              ? TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
              : TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade700,
                ),
        ),
        elevation: 7.0,
      ),
    );
  }

  Container buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6.0, left: 7, right: 7, bottom: 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 7.5 / 100,
      child: TextField(
        onChanged: (value) => filterSearchResults(value),
        decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(
            Icons.search,
            size: 22.0,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      ),
    );
  }

  Padding buildSelectedMemberNo() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Selected: ${_selectedMember.length}",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildFriendList() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => ListTile(
              leading: ClipOval(
                child: FadeInImage.assetNetwork(
                  fadeInCurve: Curves.bounceIn,
                  placeholder: _memberList[index].profilePic == null
                      ? "assets/images/default_profile.png"
                      : "assets/images/loading.gif",
                  image: _memberList[index].profilePic == null
                      ? ""
                      : '${_memberList[index].profilePic}',
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              title: Row(
                children: <Widget>[
                  Text(_memberList[index].username),
                ],
              ),
              trailing: Checkbox(
                value: _memberList[index].isChecked,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _memberList[index].isChecked = value;
                    if (value == true) {
                      _selectedMember.add(_memberList[index]);
                    } else {
                      _selectedMember.remove(_memberList[index]);
                    }
                  });
                },
              )),
          itemCount: _memberList.length),
    );
  }

  Padding buildTotalMemberNo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        "Total Members: ${_memberList.length}",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
