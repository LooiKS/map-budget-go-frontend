import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                LoginPage(toggleBrightness: widget.toggleBrightness),
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
}
