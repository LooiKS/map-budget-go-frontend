import 'package:budgetgo/screen/user_setting/currency_dropdown.dart';
import 'package:budgetgo/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about.dart';

class UserSetting extends StatefulWidget {
  final toggleBrightness;

  UserSetting(
      {Key key, this.title = 'User Settings', @required this.toggleBrightness})
      : super(key: key);

  final String title;

  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  int themeValue = 10;
  String defCurrency = 'loading';
  bool receiveNoti = true, allowPhoneSearch = true;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    var pref = Preference.pref;
    sharedPreferences = pref;
    themeValue = pref.getString('brightness') == 'Brightness.light' ? 10 : 100;
    defCurrency = pref.getString('defCurrency') == null
        ? 'MYR'
        : pref.getString('defCurrency');
    receiveNoti = pref.getBool('receiveNoti') == null
        ? true
        : pref.getBool('receiveNoti');
    allowPhoneSearch = pref.getBool('allowPhoneSearch') == null
        ? true
        : pref.getBool('allowPhoneSearch');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDivider('General'),
            _buildCurrencyListTile(context),
            _buildNotiListTile(),
            _buildThemeListTile(context),
            _buildPhoneSearchListTile(),
            _buildDivider('Help'),
            _buildAboutListTile(context),
            _buildContactUsListTile(context)
          ],
        ),
      ),
    );
  }

  Padding _buildDivider(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Text(
            '$title  ',
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
          Expanded(
              child: Divider(
            color: Colors.black,
          ))
        ],
      ),
    );
  }

  ListTile _buildContactUsListTile(BuildContext context) {
    return ListTile(
      title: Text('Contact Us'),
      onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Contact Us'),
                content: Text('Leave us a feedback at budgetgodev@gmail.com'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'))
                ],
              )),
    );
  }

  ListTile _buildAboutListTile(BuildContext context) {
    return ListTile(
        title: Text('About'),
        subtitle: Text('BudgetGo Version 1.0'),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => About())));
  }

  ListTile _buildPhoneSearchListTile() {
    return ListTile(
      title: Text('Allow others to search your account by phone number'),
      trailing: Switch(
          value: allowPhoneSearch,
          onChanged: (value) {
            setState(() => allowPhoneSearch = value);
            sharedPreferences.setBool('allowPhoneSearch', value);
          }),
    );
  }

  ListTile _buildThemeListTile(BuildContext context) {
    return ListTile(
      title: Text('Theme'),
      subtitle: Text(themeValue == 10 ? 'Light' : 'Dark'),
      onTap: () => showDialog(
          context: context,
          builder: (context) => Builder(
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  title: Text('Theme'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildBrightnessRadio(
                          10, Brightness.light, 'Light', context),
                      _buildBrightnessRadio(
                          100, Brightness.dark, 'Dark', context)
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('Cancel'),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              )),
    );
  }

  RadioListTile<int> _buildBrightnessRadio(
      int value, Brightness brightness, String title, BuildContext context) {
    return RadioListTile(
      value: value,
      groupValue: themeValue,
      onChanged: (theme) => _chengeTheme(theme, brightness, context),
      title: Text(title),
    );
  }

  void _chengeTheme(int theme, Brightness brightness, BuildContext context) {
    setState(() => themeValue = theme);
    Preference.pref.setString('brightness', brightness.toString());
    widget.toggleBrightness();
    Navigator.of(context).pop();
  }

  ListTile _buildNotiListTile() {
    return ListTile(
      title: Text('Notification'),
      subtitle: Text('Receiving notification'),
      trailing: Switch(
          value: receiveNoti,
          onChanged: (_) {
            setState(() => receiveNoti = _);
            sharedPreferences.setBool('receiveNoti', _);
          }),
    );
  }

  ListTile _buildCurrencyListTile(BuildContext context) {
    return ListTile(
      title: Text('Default Currency'),
      subtitle: Text(defCurrency),
      onTap: () => showDialog(
          context: context,
          builder: (context) => CurrencyDropdown(onChange: (newCurrency) {
                setState(() => defCurrency = newCurrency);
                sharedPreferences.setString('defCurrency', newCurrency);
              })),
    );
  }
}
