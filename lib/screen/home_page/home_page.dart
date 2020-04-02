import 'package:budgetgo/screen/profile/ProfilePage.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_shape.dart';
import '../user/user_setting.dart';
import './oval-right-clipper.dart';
import '../trips/trips_main_page.dart';

class MyHomePage extends StatefulWidget {
  final toggleBrightness;

  MyHomePage(
      {Key key, this.title = 'User Settings', @required this.toggleBrightness})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  int currentPage;
  String appBarTitle = "Home";

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  void drawerChoice(String choice) {
    print(choice);
    switch (choice) {
      case "My profile":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;

      case "Settings":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                UserSetting(toggleBrightness: widget.toggleBrightness)));
        break;
    }
  }

  getPage(int page) {
    switch (page) {
      case 0:
        return Center(
          child: Container(
            child: Text("Home"),
          ),
        );

      case 1:
        return TripsMainPage();

      case 2:
        return Center(
          child: Container(
            child: Text("Budget"),
          ),
        );

      case 3:
        return Center(
          child: Container(
            child: Text("Friends"),
          ),
        );
    }
  }

  void onBottomNavTabTapped(int index) {
    setState(() {
      currentPage = index;
      switch (index) {
        case 0:
          appBarTitle = "Home";
          break;
        case 1:
          appBarTitle = "Trips";
          break;
        case 2:
          appBarTitle = "Budget";
          break;
        case 3:
          appBarTitle = "Friends";
          break;
      }
    });
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        shape: CustomShapeBorder(),
      ),
      body: getPage(currentPage),
      drawer: buildDrawer(),
      bottomNavigationBar: AnimatedBottomNav(
        currentIndex: currentPage,
        onChange: (index) {
          onBottomNavTabTapped(index);
        },
      ),
    );
  }

  ClipPath buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
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
                        color: active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 5,
                        ),
                        image: new DecorationImage(
                          image: new ExactAssetImage('assets/images/as.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(height: 5.0),
                  Text(
                    "Maria Chin",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "@maria97",
                    style: TextStyle(color: active, fontSize: 16.0),
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
      color: divider,
    );
  }

  GestureDetector buildDrawerRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return GestureDetector(
      onTap: () {
        drawerChoice(title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
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
                  "10+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }
}

class AnimatedBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;

  const AnimatedBottomNav({Key key, this.currentIndex, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange(0),
              child: BottomNavItem(
                icon: Icons.home,
                title: "Home",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(1),
              child: BottomNavItem(
                icon: Icons.local_airport,
                title: "Trips",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(2),
              child: BottomNavItem(
                icon: Icons.attach_money,
                title: "Budget",
                isActive: currentIndex == 2,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(3),
              child: BottomNavItem(
                icon: Icons.chat,
                title: "Friends",
                isActive: currentIndex == 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final Color activeColor;
  final Color inactiveColor;
  final String title;

  const BottomNavItem(
      {Key key,
      this.isActive = false,
      this.icon,
      this.activeColor,
      this.inactiveColor,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 200),
        child: isActive
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: activeColor ?? Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeColor ?? Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              )
            : Stack(
                children: <Widget>[
                  Icon(
                    icon,
                    size: 35.0,
                    color: inactiveColor ?? Colors.grey,
                  ),
                  if (title == "Trips")
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 15,
                          maxHeight: 20,
                        ),
                        child: Text(
                          "10",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ],
              ));
  }
}
