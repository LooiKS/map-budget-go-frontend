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

  TextEditingController _email = TextEditingController();
  bool searched = false;
  bool added = false;
  User searchedUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
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
        resizeToAvoidBottomPadding: false,
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
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 6.0, left: 7, right: 7, bottom: 0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 7.5 / 100,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Search Email",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          bool _added = false;
                          print("${_email.text}");
                          final result = await userDataService.getUserByEmail(
                              email: "${_email.text}");
                          if (result != null) {
                            for (int i = 0;
                                i < widget.user.friend.length;
                                i++) {
                              if (widget.user.friend[i].id == result.id) {
                                _added = true;
                              }
                            }
                          }
                          setState(() {
                            searched = true;
                            added = _added;
                            searchedUser = result;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 2.0),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                  ),
                ),
              ),
              if (searched == true)
                searchedUser != null
                    ? ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Stack(
                                    fit: StackFit.loose,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              width: 140.0,
                                              height: 140.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 3,
                                                    color: Colors.orange),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${searchedUser.profilePic}'),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ]),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        InfoTitle(
                                            'Email: ${searchedUser.email}'),
                                        InfoTitle('ID: ${searchedUser.id}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: added
                                      ? RaisedButton(
                                          child: Text("Added"),
                                          textColor: Colors.white,
                                          color: Colors.grey,
                                          onPressed: () => null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        )
                                      : RaisedButton(
                                          child: Text("Add"),
                                          textColor: Colors.white,
                                          color: Colors.green,
                                          onPressed: () async {
                                            User _owner =
                                                User.copy(widget.user);
                                            _owner.friend.add(searchedUser);
                                            User _friend =
                                                User.copy(searchedUser);
                                            _friend.friend.add(_owner);

                                            await userDataService.updateUser(
                                                id: searchedUser.id,
                                                user: _friend);
                                            await userDataService.updateUser(
                                                id: widget.user.id,
                                                user: _owner);

                                            showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      Text('Succcess Message'),
                                                  content: const Text(
                                                      'Added Successfully.'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('Ok'),
                                                      onPressed: () {
                                                        setState(() {
                                                          added = true;
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          "User does not exist",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
            ],
          ),
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
            ExactAssetImage('assets/images/search_icon.png'), "Email")
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
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              title: FlatButton(
                child: SizedBox(
                  width: double.infinity,
                  child: widget.user.friend[index].username == ""
                      ? Text(
                          "${widget.user.friend[index].email}",
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.left,
                        )
                      : Text(
                          "${widget.user.friend[index].username}",
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.left,
                        ),
                ),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Friend Info'),
                        content: Container(
                          height: 300.0,
                          width: 500.0,
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 110.0,
                                  height: 110.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 3, color: Colors.orange),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${widget.user.friend[index].profilePic}'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              InfoTitle('ID: ${widget.user.friend[index].id}'),
                              InfoTitle(
                                  'Email: ${widget.user.friend[index].email}'),
                              InfoTitle(
                                  'Userame: ${widget.user.friend[index].username}'),
                              InfoTitle(
                                  'Name: ${widget.user.friend[index].firstName} ${widget.user.friend[index].lastName}'),
                              InfoTitle(
                                  'Phone No.: ${widget.user.friend[index].phoneNum}'),
                            ],
                          ),
                        ),
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
                },
              ),
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
                                      content:
                                          const Text('Delete Successfully.'),
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

class InfoTitle extends StatelessWidget {
  final title;
  const InfoTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}
