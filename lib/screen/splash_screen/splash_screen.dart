import 'package:budgetgo/model/base_auth.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/home_page/home_page.dart';
import 'package:budgetgo/services/users_date_service.dart';
import 'package:budgetgo/utils/preference.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../login/login.dart';
import '../../constant/auth_status.dart';

class SplashScreen extends StatefulWidget {
  final toggleBrightness;
  final BaseAuth auth;

  SplashScreen({this.toggleBrightness, this.auth});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String uid = "";

  Future<AuthStatus> validateUser() async {
    final result = await widget.auth.getCurrentUser();
    User user;
    if (result != null) {
      user = await userDataService.getUser(id: result.uid);
      setState(() {
        uid = result?.uid;
      });
    }
    authStatus =
        result?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
    print('Status is:  $authStatus');
    Utils.fuser = result;
    Utils.user = user;
    return authStatus;
  }

  @override
  void initState() {
    super.initState();
    validateUser();
    Future.delayed(Duration(seconds: 8), () {
      switch (authStatus) {
        case AuthStatus.NOT_LOGGED_IN:
          print("Not logged in $uid");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    LoginPage(toggleBrightness: widget.toggleBrightness),
              ));
          break;

        case AuthStatus.LOGGED_IN:
          print("User logged in,redirect to homepage...");
          print('UserID: $uid');
          if (uid.length > 0 && uid != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                      toggleBrightness: widget.toggleBrightness,
                      auth: widget.auth,
                      uid: uid),
                ));
          }
          break;

        default:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    LoginPage(toggleBrightness: widget.toggleBrightness),
              ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      "assets/rive_flr/SplashScreen.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: "latest",
    );
  }
}
