import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/services/trip_data_service.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../main.dart';

class AddMember extends StatefulWidget {
  final Trips tripData;
  AddMember(this.tripData);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final dataService = TripDataService();
  List<User> _friendList = [];
  List<User> _fixedMember = [];
  List<User> _selectedMember = [];
  @override
  void initState() {
    _friendList.addAll(widget.tripData.owner.friend);
    for (User friend in widget.tripData.owner.friend) {
      friend.isChecked = false;
      for (User member in widget.tripData.members) {
        if (friend.id == member.id) {
          setState(() {
            friend.isChecked = true;
          });
        }
      }
    }
    for (User friend in _friendList) {
      if (friend.isChecked == true) {
        _fixedMember.add(friend);
      }
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
        _friendList.clear();
        _friendList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _friendList.clear();
        _friendList.addAll(widget.tripData.owner.friend);
      });
    }
  }

  void _saveButton() {
    if (_selectedMember.length > 0) {
      setState(() {
        widget.tripData.members.addAll(_selectedMember);
        dataService.updateTrip(widget.tripData.id, widget.tripData);
      });
    }
    Navigator.of(context).pop(widget.tripData);
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
  }

  void _backButton() {
    if (_selectedMember.length > 0) {
      _requestPopMessage(context);
    } else {
      Navigator.pop(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _backButton();
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => _backButton(),
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            "Add Member",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: buildTabBarView(context),
      ),
    );
  }

  Container buildTabBarView(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildSearchBar(context),
          if (_selectedMember.length > 0)
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Selected: ${_selectedMember.length}",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      buildSaveCancelBtn("Save"),
                      buildSaveCancelBtn("Cancel"),
                    ],
                  ),
                ],
              ),
            ),
          buildFriendList(),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(
              "Total Friend: ${_friendList.length}",
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      ),
    );
  }

  Container buildTabBarItem(ExactAssetImage image, String title) {
    return Container(
      height: 58.0,
      child: Tab(
        child: Column(
          children: <Widget>[
            Container(
              width: 35.0,
              height: 35.0,
              margin: EdgeInsets.only(bottom: 5.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: key.currentState.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.transparent,
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.contain,
                  )),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
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

  ButtonTheme buildSaveCancelBtn(String title) {
    return ButtonTheme(
      minWidth: 10.0,
      height: 28.0,
      child: RaisedButton(
        onPressed: title == "Save"
            ? () => _saveButton()
            : () {
                setState(() {
                  for (User member in _selectedMember) {
                    member.isChecked = false;
                  }
                  _selectedMember.clear();
                });
              },
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
                  placeholder: _friendList[index].profilePic == null
                      ? "assets/images/default_profile.png"
                      : "assets/images/loading.gif",
                  image: _friendList[index].profilePic == null
                      ? ""
                      : '${_friendList[index].profilePic}',
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              title: Text(_friendList[index].username),
              trailing: _fixedMember
                      .contains(widget.tripData.owner.friend[index])
                  ? Checkbox(
                      onChanged: null,
                      value: widget.tripData.owner.friend[index].isChecked,
                    )
                  : Checkbox(
                      value: _friendList[index].isChecked,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _friendList[index].isChecked = value;
                          if (value == true) {
                            _selectedMember
                                .add(widget.tripData.owner.friend[index]);
                          } else {
                            _selectedMember
                                .remove(widget.tripData.owner.friend[index]);
                          }
                        });
                      },
                    )),
          itemCount: _friendList.length),
    );
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
}
