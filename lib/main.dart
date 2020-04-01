import './screen/user/user_setting.dart';
import 'package:budgetgo/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screen/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preference.pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}

class MainApp extends StatefulWidget {
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
      theme: ThemeData(
        brightness: brightness,
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(
        toggleBrightness: toggleBrightness,
      ),
    );
  }
}
