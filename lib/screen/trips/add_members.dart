import 'package:budgetgo/model/trips_class.dart';
import 'package:flutter/material.dart';

class AddMember extends StatefulWidget {
  final Trips hostData;
  AddMember(this.hostData);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Add Member",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(10.0, 80.0),
            child: TabBar(tabs: [
              Container(
                height: 80.0,
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
                height: 80.0,
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
                                  'assets/images/qrcode.png'),
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
                height: 80.0,
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
              color: Colors.pink,
              child: Center(child: Text("Call Tab")),
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
