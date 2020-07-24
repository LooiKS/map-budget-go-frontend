import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/widget/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:budgetgo/services/expense_data_service.dart';
import 'package:budgetgo/services/trip_data_service.dart';

class AddExpenseScreen extends StatefulWidget {
  final Trips trip;

  AddExpenseScreen(this.trip);
  @override
  AddExpenseScreenState createState() => AddExpenseScreenState();
}

class AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _categoryList = <String>[
    'Accommodation',
    'Transport',
    'Food & Beverage',
    'Entertainment',
    'Others'
  ];
  String _categoty = 'Accommodation';
  String title, description;
  double total;
  ExpensesDataService expensesDataService = ExpensesDataService();
  TripDataService tripDataService = TripDataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expense",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    onChanged: (String value) {
                      setState(() {
                        title = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Title: ",
                      labelStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Enter Expense Title",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    onChanged: (String value) {
                      setState(() {
                        description = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Description: ",
                      labelStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Enter Expense Description",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Category:',
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _categoty == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: _categoty,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                // _expenses.category = newValue;
                                _categoty = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _categoryList.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (value) {
                      return value == '' ? 'Please choose one' : null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    onChanged: (String value) {
                      setState(() {
                        total = double.parse(value);
                      });
                    },
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2),
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Total Amount: ",
                      labelStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Enter Amount",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Container(
                              child: new RaisedButton(
                            child: new Text("Create"),
                            textColor: Colors.white,
                            color: Colors.green,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                TripExpenses _expense = new TripExpenses(
                                  title: title.trim(),
                                  desc: description.trim(),
                                  category: _categoty,
                                  createdDt: DateTime.now(),
                                  amount: total,
                                  payBy: widget.trip.owner,
                                  createdBy: widget.trip.owner,
                                  sharedBy: widget.trip.members,
                                );
                                TripExpenses expense = await expensesDataService
                                    .createExpense(_expense);
                                widget.trip.expenses.add(expense);
                                tripDataService.updateTrip(
                                    widget.trip.id, widget.trip);
                                Navigator.pop(context, expense);
                              }
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          )),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Container(
                              child: new RaisedButton(
                            child: new Text("Cancel"),
                            textColor: Colors.white,
                            color: Colors.red,
                            onPressed: () {
                              Navigator.pop(context, null);
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          )),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
