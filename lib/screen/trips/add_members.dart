import 'package:flutter/material.dart';
import '../../model/trips_class.dart';
import '../../model/user.dart';

class AddMember extends StatefulWidget {
  final Trips trip;
  AddMember(this.trip);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<User> _friendList = List<User>();

  @override
  void initState() {
    _friendList.addAll(widget.trip.owner.friend);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<User> dummySearchList = List<User>();
    dummySearchList.addAll(widget.trip.owner.friend);
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
        _friendList.addAll(widget.trip.owner.friend);
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
                    padding: const EdgeInsets.all(8.0),
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
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                              trailing: widget.trip.members
                                      .contains(_friendList[index])
                                  ? Checkbox(
                                      value: true,
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      onChanged: (value) {},
                                    )
                                  : Checkbox(
                                      value: false,
                                      onChanged: (value) {},
                                    ),
                            ),
                        separatorBuilder: (context, index) => Divider(),
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
