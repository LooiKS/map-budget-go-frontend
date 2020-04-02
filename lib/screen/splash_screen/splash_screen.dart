import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../home_page/home_page.dart';
import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  final toggleBrightness;

  SplashScreen({this.toggleBrightness});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      // Navigator.of(context).pushReplacement(_createRoute());
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(toggleBrightness: widget.toggleBrightness),
            ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlareActor(
        "assets/rive_flr/SplashScreen.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "latest",
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          MyHomePage(toggleBrightness: widget.toggleBrightness),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.5, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: curve,
              ),
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1.5,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.50,
                  1.00,
                  curve: curve,
                ),
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
