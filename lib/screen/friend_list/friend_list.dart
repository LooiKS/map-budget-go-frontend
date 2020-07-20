import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/services/users_date_service.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../main.dart';

class FriendList extends StatefulWidget {
  User user;

  FriendList({this.user});
  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  List<User> _friendList = [];
  List<User> _selectedMember = [];
  @override
  void initState() {
    print("Yes");
    print(widget.user.friend);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<User> dummySearchList = List<User>();
    dummySearchList.addAll(widget.user.friend);
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
        _friendList.addAll(widget.user.friend);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: buildTab(),
        ),
        body: buildTabBarView(context),
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
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              buildFriendList(),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  "Total Friend: ${widget.user.friend.length}",
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
      preferredSize: Size(10.0, 5.0),
      child: TabBar(indicatorColor: Colors.purple, tabs: [
        buildTabBarItem(
            ExactAssetImage('assets/images/contact_book.png'), "Friend List"),
        buildTabBarItem(
            ExactAssetImage('assets/images/search_icon.png'), "ID/Phone No.")
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
                  image: widget.user.friend[index].profilePic,
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              title: widget.user.friend[index].username == ""
                  ? Text("${widget.user.friend[index].phoneNum}")
                  : Text("${widget.user.friend[index].username}"),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Friend'),
                        content: const Text(
                            'This will delete the friend from your friend list.'),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: const Text('Confirm'),
                            onPressed: () async {
                              setState(() {
                                widget.user.friend.removeAt(index);
                              });
                              final result = await userDataService.updateUser(
                                  id: widget.user.id, user: widget.user);
                              if (result != null) {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Update Message'),
                                      content: const Text(
                                          'Delete Successfully.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              )),
          itemCount: widget.user.friend.length),
    );
  }
}
