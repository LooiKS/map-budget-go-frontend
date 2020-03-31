import 'package:budgetgo/constant/currency.dart';
import 'package:budgetgo/user/about.dart';
import 'package:budgetgo/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var onValue = Preference.pref;
    sharedPreferences = onValue;
    themeValue =
        onValue.getString('brightness') == 'Brightness.light' ? 10 : 100;
    defCurrency = onValue.getString('defCurrency') == null
        ? 'MYR'
        : onValue.getString('defCurrency');
    receiveNoti = onValue.getBool('receiveNoti') == null
        ? true
        : onValue.getBool('receiveNoti');
    allowPhoneSearch = onValue.getBool('allowPhoneSearch') == null
        ? true
        : onValue.getBool('allowPhoneSearch');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildGeneralDivider(),
          _buildCurrencyListTile(context),
          _buildNotiListTile(),
          _buildThemeListTile(context),
          _buildPhoneSearchListTile(),
          _buildHelpDivider(),
          _buildAboutListTile(context),
          _buildContactUsListTile(context)
        ],
      ),
    );
  }

  Padding _buildGeneralDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Text(
            'General  ',
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

  Padding _buildHelpDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Text(
            'Help  ',
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
          onChanged: (_) {
            setState(() {
              allowPhoneSearch = _;
            });
            sharedPreferences.setBool('allowPhoneSearch', _);
          }),
    );
  }

  ListTile _buildThemeListTile(BuildContext context) {
    return ListTile(
      title: Text('Theme'),
      subtitle: Text(themeValue == 10 ? 'Light' : 'Dark'),
      onTap: () => showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  title: Text('Theme'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile(
                        value: 10,
                        groupValue: themeValue,
                        onChanged: (theme) {
                          setState(() {
                            themeValue = theme;
                          });
                          SharedPreferences.getInstance().then((onValue) =>
                              onValue.setString(
                                  'brightness', Brightness.light.toString()));
                          widget.toggleBrightness();
                          Navigator.of(context).pop();
                        },
                        selected: false,
                        title: Text('Light'),
                      ),
                      RadioListTile(
                        value: 100,
                        groupValue: themeValue,
                        onChanged: (theme) {
                          setState(() {
                            themeValue = theme;
                          });
                          SharedPreferences.getInstance().then((onValue) =>
                              onValue.setString(
                                  'brightness', Brightness.dark.toString()));
                          widget.toggleBrightness();
                          Navigator.of(context).pop();
                        },
                        title: Text('Dark'),
                      )
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

  ListTile _buildNotiListTile() {
    return ListTile(
      title: Text('Notification'),
      subtitle: Text('Receiving notification'),
      trailing: Switch(
          value: receiveNoti,
          onChanged: (_) {
            setState(() {
              receiveNoti = _;
            });
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
          builder: (context) => AlertDialog(
                title: Text('Default Currency'),
                content: DropdownButton<String>(
                    value: defCurrency,
                    items: Currency.currency.map<DropdownMenuItem<String>>(
                      (currencyCode) {
                        return DropdownMenuItem(
                          child: Text(currencyCode),
                          value: currencyCode,
                        );
                      },
                    ).toList(),
                    onChanged: (a) {
                      setState(() {
                        defCurrency = a;
                        themeValue = 100;
                      });
                      sharedPreferences.setString('defCurrency', a);
                      Navigator.of(context).pop();
                    }),
                actions: <Widget>[
                  FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('Cancel'),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )),
    );
  }
}
