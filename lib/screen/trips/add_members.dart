import 'package:budgetgo/model/trips_class.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';

class AddMember extends StatefulWidget {
  final Trips tripData;
  AddMember(this.tripData);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<User> _friendList = [];
  List<User> _selectedMember = [];
  bool _isVisible = true;
  int _isSelected = 0;
  @override
  void initState() {
    _selectedMember.addAll(widget.tripData.members);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Manage Member",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {},
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size(10.0, 55.0),
              child: TabBar(indicatorColor: Colors.black, tabs: [
                Container(
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
                              image: DecorationImage(
                                image: ExactAssetImage(
                                    'assets/images/contact_book.png'),
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(
                          "Friend List",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
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
                              image: DecorationImage(
                                image:
                                    ExactAssetImage('assets/images/qrcode.png'),
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(
                          "QR Code",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
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
                              image: DecorationImage(
                                image: ExactAssetImage(
                                    'assets/images/search_icon.png'),
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(
                          "ID/Phone No.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            elevation: 0,
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        onChanged: (value) => filterSearchResults(value),
                        decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 10.0,
                            height: 28.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop(widget.tripData);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text("Save"),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          ButtonTheme(
                            minWidth: 10.0,
                            height: 28.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop(null);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text("Cancel"),
                            ),
                          ),
                        ],
                      ),
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
                                    image: widget.tripData.owner.friend[index]
                                        .profilePic,
                                    fit: BoxFit.contain,
                                    width: 40.0,
                                    height: 40.0,
                                  ),
                                ),
                                title: Row(
                                  children: <Widget>[
                                    Text(widget
                                        .tripData.owner.friend[index].username),
                                  ],
                                ),
                                trailing: widget
                                        .tripData.owner.friend[index].isChecked
                                    ? Checkbox(
                                        onChanged: null,
                                        value: widget.tripData.owner
                                            .friend[index].isChecked,
                                      )
                                    : Checkbox(
                                        value: widget.tripData.owner
                                            .friend[index].isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            widget.tripData.owner.friend[index]
                                                .isChecked = value;
                                            if (value == true) {
                                              _selectedMember.add(widget
                                                  .tripData
                                                  .owner
                                                  .friend[index]);
                                              // widget.tripData.members.add(widget
                                              //     .tripData.owner.friend[index]);
                                            } else {
                                              _selectedMember.remove(widget
                                                  .tripData
                                                  .owner
                                                  .friend[index]);
                                              // widget.tripData.members.remove(widget
                                              //     .tripData.owner.friend[index]);
                                            }
                                          });
                                        },
                                      ),
                              ),
                          itemCount: widget.tripData.owner.friend.length),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.pink,
                child: Center(child: Text("Call Tab")),
              ),
              Container(
                color: Colors.blue,
                child: Center(child: Text("Call Tab")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
