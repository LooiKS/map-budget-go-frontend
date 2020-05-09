import 'package:budgetgo/model/mockdata.dart';
import 'package:budgetgo/screen/home_page/home_page.dart';
import 'package:budgetgo/screen/schedule/schedule_detail_screen.dart';
import 'package:budgetgo/screen/splash_screen/splash_screen.dart';
import 'package:budgetgo/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preference.pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainApp(
      key: key,
    );
  }
}

var key = new GlobalKey<MainAppState>();

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  Brightness brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        brightness = onValue.getString('brightness') == 'Brightness.light'
            ? Brightness.light
            : Brightness.dark;
      });
    });
  }

  void toggleBrightness() {
    setState(() {
      brightness =
          brightness == Brightness.light ? Brightness.dark : Brightness.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetGo',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/scheduledetails':
            return MaterialPageRoute(
                settings: RouteSettings(name: settings.name),
                builder: (context) => ScheduleDetailScreen(settings.arguments));
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: brightness,
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(toggleBrightness: toggleBrightness),
    );
  }
}
