import 'package:budgetgo/model/trips_class.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';

class DelMembers extends StatefulWidget {
  final Trips tripData;
  DelMembers(this.tripData);

  @override
  _DelMembersState createState() => _DelMembersState();
}

class _DelMembersState extends State<DelMembers> {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            "Remove Members",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 23 / 100,
              padding:
                  const EdgeInsets.only(right: 8.0, top: 13.0, bottom: 13.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                disabledColor: Colors.orangeAccent,
                color: Colors.red,
                onPressed: _selectedMember.length > 0
                    ? () {
                        setState(() {
                          widget.tripData.members.clear();
                          widget.tripData.members.addAll(_selectedMember);
                        });
                        Navigator.of(context).pop(widget.tripData);
                      }
                    : null,
                child: Text(
                  "Delete",
                  style: TextStyle(
                    fontWeight: _selectedMember.length > 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color:
                        _selectedMember.length > 0 ? Colors.white : Colors.grey,
                  ),
                ),
                elevation: 7.0,
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    top: 6.0, left: 7, right: 7, bottom: 0),
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
              ),
              _selectedMember.length > 0
                  ? Padding(
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
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(0.0),
                    ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                        leading: ClipOval(
                          child: FadeInImage.assetNetwork(
                            fadeInCurve: Curves.bounceIn,
                            placeholder: "assets/images/loading.gif",
                            image: _memberList[index].profilePic,
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  "Total Members: ${_memberList.length}",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
