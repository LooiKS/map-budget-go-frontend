import 'package:budgetgo/services/users_date_service.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';

class FriendList extends StatefulWidget {
  final User user;

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
    _friendList = widget.user.friend;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future searchEmail() async {
    bool _added = false;
    final result =
        await userDataService.getUserByEmail(email: "${_email.text}");
    if (result != null) {
      for (int i = 0; i < widget.user.friend.length; i++) {
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
  }

  Future addFriend() async {
    User _owner = User.copy(widget.user);
    User _friend = User.copy(searchedUser);
    setState(() {
      _owner.friend.add(searchedUser);
      _friend.friend.add(_owner);
      _friendList.add(searchedUser);
    });

    await userDataService.updateUser(id: searchedUser.id, user: _friend);
    await userDataService.updateUser(id: widget.user.id, user: _owner);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Succcess Message'),
          content: const Text('Added Successfully.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                setState(() {
                  added = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future confirmDeleteFriend(int index) async {
    setState(() {
      _friendList.removeAt(index);
    });
    final result =
        await userDataService.updateUser(id: widget.user.id, user: widget.user);

    if (result != null) {
      print("delete");
      print(result.friend);
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Message'),
            content: const Text('Delete Successfully.'),
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
        appBar: buildTab(),
        body: buildTabBarView(context),
      ),
    );
  }

  PreferredSize buildTab() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 30.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          TabBar(
            indicatorColor: Colors.purple,
            tabs: [
              buildTabBarItem(Icons.account_box, "Friend List"),
              buildTabBarItem(Icons.search, "Email")
            ],
          )
        ],
      ),
    );
  }

  Container buildTabBarItem(IconData icons, String title) {
    return Container(
      height: 58.0,
      child: Tab(
        child: Column(
          children: <Widget>[
            Icon(icons, size: 35.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBarView buildTabBarView(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Tab(child: _buildFriendContainer(context)),
        Tab(child: _buildSearchEmail(context)),
      ],
    );
  }

  Container _buildFriendContainer(BuildContext context) {
    return Container(
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
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              title: FlatButton(
                child: SizedBox(
                    width: double.infinity,
                    child: _friendList[index].username == ""
                        ? _buildListTitleText(
                            title: "${_friendList[index].email}", index: index)
                        : _buildListTitleText(
                            title: "${_friendList[index].username}",
                            index: index)),
                onPressed: () {
                  _buildShowFriendInfo(context, index);
                },
              ),
              trailing: _buildDeleteFriendButton(context, index)),
          itemCount: _friendList.length),
    );
  }

  Text _buildListTitleText({String title, int index}) {
    return Text(
      title,
      style: TextStyle(fontSize: 16.0),
      textAlign: TextAlign.left,
    );
  }

  Future _buildShowFriendInfo(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friend Info'),
          content: Container(
            width: 500.0,
            padding: EdgeInsets.all(5.0),
            child: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.orange),
                        image: DecorationImage(
                          image: widget.user.friend[index].profilePic == null
                              ? AssetImage("assets/images/default_profile.png")
                              : NetworkImage(
                                  '${widget.user.friend[index].profilePic}'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  InfoTitle('Email: ${widget.user.friend[index].email}'),
                  InfoTitle('Userame: ${widget.user.friend[index].username}'),
                  InfoTitle(
                      'Name: ${widget.user.friend[index].firstName} ${widget.user.friend[index].lastName}'),
                  InfoTitle('Phone No.: ${widget.user.friend[index].phoneNum}'),
                  InfoTitle('Gender: ${widget.user.friend[index].gender}'),
                ],
              ),
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
  }

  IconButton _buildDeleteFriendButton(BuildContext context, int index) {
    return IconButton(
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
                _buildFlatButton(context: context, title: "Cancel"),
                _buildFlatButton(
                    context: context, title: "Confirm", index: index),
              ],
            );
          },
        );
      },
    );
  }

  FlatButton _buildFlatButton({BuildContext context, String title, int index}) {
    return FlatButton(
      child: Text('$title'),
      onPressed: () async => title == "Cancel"
          ? Navigator.of(context).pop()
          : await confirmDeleteFriend(index),
    );
  }

// --------------------------------- Search User By Email ------------------------------
  Container _buildSearchEmail(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildSearchEmailBar(context),
          if (searched == true)
            searchedUser != null
                ? _buildUserSearched()
                : Center(
                    child: Text(
                      "User does not exist",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
        ],
      ),
    );
  }

  Flexible _buildUserSearched() {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Stack(fit: StackFit.loose, children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.orange),
                        image: DecorationImage(
                          image: searchedUser.profilePic == null
                              ? AssetImage("assets/images/default_profile.png")
                              : NetworkImage('${searchedUser.profilePic}'),
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InfoTitle('Email: ${searchedUser.email}'),
                InfoTitle(searchedUser.username == null
                    ? 'Username: -'
                    : 'Username: ${searchedUser.username}'),
                InfoTitle(searchedUser.gender == null
                    ? 'Gender: -'
                    : 'Gender: ${searchedUser.gender}'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 70.0),
            child: Container(
                child: added
                    ? _buildAddUserButton(title: "Added", color: Colors.grey)
                    : _buildAddUserButton(title: "Add", color: Colors.green)),
          ),
        ],
      ),
    );
  }

  RaisedButton _buildAddUserButton({String title, Color color}) {
    return RaisedButton(
      child: Text("$title"),
      textColor: Colors.white,
      color: color,
      onPressed: () => title == "Added" ? null : addFriend(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }

  Padding _buildSearchEmailBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 6.0, left: 7, right: 7, bottom: 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 7.5 / 100,
        child: TextField(
          controller: _email,
          decoration: InputDecoration(
            hintText: "Search Email",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => searchEmail(),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
        ),
      ),
    );
  }
}

class InfoTitle extends StatelessWidget {
  final title;
  const InfoTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ));
  }
}
