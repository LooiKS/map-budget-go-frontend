import 'package:budgetgo/model/base_auth.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/friend_list/friend_list.dart';
import 'package:budgetgo/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_shape.dart';
import '../user_setting/user_setting.dart';
import './oval_right_clipper.dart';
import './animatedBottomNav.dart';
import '../signout/signout.dart';
import '../trips/trips_main_page.dart';
import '../notification/notification_page.dart';
import '../../services/users_data_service.dart';

class MyHomePage extends StatefulWidget {
  final toggleBrightness;
  final BaseAuth auth;
  final String uid;

  MyHomePage({Key key, this.toggleBrightness, this.auth, this.uid})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage;
  String appBarTitle = "BudgetGO";

  User _user;

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  void onDrawerRowTapped(String choice) async {
    switch (choice) {
      case "My profile":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                    user: _user,
                    auth: widget.auth,
                  )),
        );
        break;

      case "Settings":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                UserSetting(toggleBrightness: widget.toggleBrightness)));
        break;

      case "Notifications":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NotificationPage()));
        break;

      case "Log out":
        await widget.auth.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => LogoutPage(
                      toggleBrightness: widget.toggleBrightness,
                      auth: widget.auth,
                    )),
            (_) => false);
        break;
    }
  }

  getPage(int page) {
    switch (page) {
      case 0:
        return TripsMainPage(user: _user);

      case 1:
        return FriendList(user: _user);
    }
  }

  void onBottomNavTabTapped(int index) {
    setState(() {
      currentPage = index;
      switch (index) {
        case 0:
          appBarTitle = "Trips";
          break;
        case 1:
          appBarTitle = "Friends";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: userDataService.getUser(id: widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _user = snapshot.data;
            return buildScaffold();
          }
          return _buildLoading();
        });
  }

  Scaffold _buildLoading() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(appBarTitle),
        shape: CustomShapeBorder(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching data... Please wait'),
          ],
        ),
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        shape: CustomShapeBorder(),
      ),
      body: getPage(currentPage),
      drawer: buildDrawer(),
      bottomNavigationBar: AnimatedBottomNav(
        currentIndex: currentPage,
        onChange: (index) => onBottomNavTabTapped(index),
      ),
    );
  }

  ClipPath buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 35),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                      ),
                      onPressed: () async {
                        await widget.auth.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LogoutPage(
                                      toggleBrightness: widget.toggleBrightness,
                                      auth: widget.auth,
                                    )),
                            (_) => false);
                      },
                    ),
                  ),
                  Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 5,
                        ),
                        image: DecorationImage(
                          image: _user.profilePic == null
                              ? AssetImage("assets/images/default_profile.png")
                              : NetworkImage('${_user.profilePic}'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(height: 5.0),
                  Text(
                    _user.firstName == null || _user.lastName == null
                        ? ""
                        : "${_user.firstName} ${_user.lastName}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    _user.username == null ? '' : '@${_user.username}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  buildDrawerRow(Icons.home, "Home"),
                  buildDivider(),
                  buildDrawerRow(Icons.person_pin, "My profile"),
                  buildDivider(),
                  buildDrawerRow(Icons.notifications, "Notifications",
                      showBadge: true),
                  buildDivider(),
                  buildDrawerRow(Icons.settings, "Settings"),
                  buildDivider(),
                  buildDrawerRow(Icons.power_settings_new, "Log out"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      color: Colors.grey.shade500,
    );
  }

  GestureDetector buildDrawerRow(IconData icon, String title,
      {bool showBadge = false}) {
    return GestureDetector(
      onTap: () {
        onDrawerRowTapped(title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          ),
          Spacer(),
          showBadge
              ? Material(
                  color: Colors.deepOrange,
                  elevation: 5.0,
                  shadowColor: Colors.red,
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "2",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
