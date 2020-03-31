import 'package:budgetgo/user/user_setting.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.amber,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Text(
                  'BudgetGo',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('User Settings'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      UserSetting(toggleBrightness: widget.toggleBrightness))),
            ),
          ],
        ),
      ),
    );
  }
}
