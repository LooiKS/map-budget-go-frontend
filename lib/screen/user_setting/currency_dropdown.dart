import 'package:budgetgo/constant/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatefulWidget {
  CurrencyDropdown({this.onChange});
  final ValueChanged<String> onChange;

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  String currencyFilter = '';
  TextEditingController _textFilterController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default Currency'),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: TextField(
              controller: _textFilterController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
              onChanged: (newText) {
                setState(() {
                  currencyFilter = newText;
                });
              },
            ),
          )
        ],
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ListView(
          children: Currency.currency
              .where((friend) =>
                  RegExp('^(?:.*$currencyFilter).*\$').hasMatch(friend))
              .map((currencyCode) {
            return ListTile(
              title: Container(
                child: Text(currencyCode),
                padding: EdgeInsets.all(2.0),
              ),
              onTap: () {
                widget.onChange(currencyCode);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
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
    );
  }
}
