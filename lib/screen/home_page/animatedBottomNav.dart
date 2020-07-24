import 'package:budgetgo/model/mockdata.dart';
import 'package:flutter/material.dart';

class AnimatedBottomNav extends StatelessWidget {
  final state;
  final int currentIndex;
  final Function(int) onChange;

  const AnimatedBottomNav(
      {Key key, this.state, this.currentIndex, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          buildExpanded(0, Icons.place, "Trips"),
          buildExpanded(1, Icons.person, "Friends"),
        ],
      ),
    );
  }

  Expanded buildExpanded(int index, IconData icons, String title) {
    return Expanded(
      child: InkWell(
        onTap: () => onChange(index),
        child: BottomNavItem(
          icon: icons,
          title: title,
          isActive: currentIndex == index,
        ),
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
    int count = mockdata.where((c) => c.status == "progress").toList().length;

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
                              count.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            )))
                ],
              ));
  }
}
