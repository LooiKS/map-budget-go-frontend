import 'package:budgetgo/model/trips_class.dart';
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
  List<User> _friendList = [];
  List<User> _selectedMember = [];
  @override
  void initState() {
    _friendList.addAll(widget.tripData.owner.friend);
    for (User friend in widget.tripData.owner.friend) {
      if (widget.tripData.members.contains(friend)) {
        setState(() {
          friend.isChecked = true;
        });
      } else {
        setState(() {
          friend.isChecked = false;
        });
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
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () => _backButton(),
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              "Add Member",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            bottom: buildTab(),
          ),
          body: buildTabBarView(context),
        ),
      ),
    );
  }

  TabBarView buildTabBarView(BuildContext context) {
    return TabBarView(
          children: <Widget>[
            Container(
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
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
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
            ),
            Container(
              color: Colors.blue,
              child: Center(child: Text("Call Tab")),
            ),
          ],
        );
  }

  PreferredSize buildTab() {
    return PreferredSize(
            preferredSize: Size(10.0, 55.0),
            child: TabBar(indicatorColor: Colors.purple, tabs: [
              buildTabBarItem(
                  ExactAssetImage('assets/images/contact_book.png'),
                  "Friend List"),
              buildTabBarItem(
                  ExactAssetImage('assets/images/search_icon.png'),
                  "ID/Phone No.")
            ]),
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
                  placeholder: "assets/images/loading.gif",
                  image: _friendList[index].profilePic,
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              title: Text(_friendList[index].username),
              trailing: widget.tripData.owner.friend[index].isChecked &&
                      widget.tripData.members
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
