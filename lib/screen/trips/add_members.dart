import 'package:budgetgo/model/trips_class.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';

class AddMember extends StatefulWidget {
  // final List<User> members;
  // User owner;
  // AddMember(this.members, this.owner);
  final Trips data;
  AddMember(this.data);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<User> _friendList = List<User>();
  bool _isMember = true;
  bool _isVisible = true;

  @override
  void initState() {
    _friendList.addAll(widget.data.owner.friend);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<User> dummySearchList = List<User>();
    dummySearchList.addAll(widget.data.owner.friend);
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
        _friendList.addAll(widget.data.owner.friend);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Member",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  !_isVisible
                      ? Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 10.0,
                                height: 28.0,
                                child: RaisedButton(
                                  onPressed: () {},
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
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text("Cancel"),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  Expanded(
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
                              title: Row(
                                children: <Widget>[
                                  Text(_friendList[index].username),
                                ],
                              ),
                              trailing:
                                  widget.data.members.contains(_friendList[index])
                                      ? Checkbox(
                                          value: _isMember,
                                          activeColor: Colors.green,
                                          checkColor: Colors.white,
                                          onChanged: (value) {
                                            setState(() {
                                              _isMember = value;
                                            });
                                          },
                                        )
                                      : Checkbox(
                                          value: !_isMember,
                                          onChanged: (value) {},
                                        ),
                            ),
                        itemCount: _friendList.length),
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
    );
  }
}
