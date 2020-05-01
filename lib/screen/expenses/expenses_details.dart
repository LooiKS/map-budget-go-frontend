import 'package:budgetgo/main.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/widget/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class ExpenseDetailsScreen extends StatefulWidget {
  final TripExpenses expense;
  ExpenseDetailsScreen(this.expense);
  @override
  ExpenseDetailsScreenState createState() => ExpenseDetailsScreenState();
}

class ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _categoryList = <String>[
    'Accommodation',
    'Transport',
    'Food & Beverage',
    'Entertainment',
    'Others'
  ];
  String _categoty = 'Accommodation';
  String title, description, paidBy, shareWith;
  double total;
  bool titleStatus = false;
  bool descStatus = false;
  bool categoryStatus = false;
  bool totalStatus = false;

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
                  padding: EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onChanged: (String value) {
                            title = value;
                          },
                          decoration: InputDecoration(
                            labelText: "Title: ",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: key.currentState.brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87),
                            hintText: "Enter Expense Title",
                          ),
                          initialValue: widget.expense.title,
                          enabled: titleStatus,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        flex: 5,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            titleStatus == false
                                ? IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        titleStatus = true;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.check,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (title != null) {
                                          widget.expense.title = title;
                                        }
                                        titleStatus = false;
                                      });
                                    },
                                  ),
                          ],
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onChanged: (String value) {
                            description = value;
                          },
                          decoration: InputDecoration(
                            labelText: "Description: ",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: key.currentState.brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87),
                            hintText: "Enter Expense Description",
                          ),
                          initialValue: widget.expense.desc,
                          enabled: descStatus,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        flex: 5,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            descStatus == false
                                ? IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        descStatus = true;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.check,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (description != null) {
                                          widget.expense.desc = description;
                                        }
                                        descStatus = false;
                                      });
                                    },
                                  ),
                          ],
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: categoryStatus == false
                            ? TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Category: ",
                                  labelStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: key.currentState.brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                                initialValue: widget.expense.category,
                                enabled: false,
                              )
                            : FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Category:',
                                      labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: key.currentState.brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black87),
                                      errorText: state.hasError
                                          ? state.errorText
                                          : null,
                                    ),
                                    isEmpty: _categoty == '',
                                    child: new DropdownButtonHideUnderline(
                                      child: new DropdownButton<String>(
                                        value: _categoty,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(
                                            () {
                                              _categoty = newValue;
                                              state.didChange(newValue);
                                            },
                                          );
                                        },
                                        items:
                                            _categoryList.map((String value) {
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
                                  return value == ''
                                      ? 'Please choose one'
                                      : null;
                                },
                              ),
                        flex: 5,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            categoryStatus == false
                                ? IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        categoryStatus = true;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.check,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_categoty != null) {
                                          widget.expense.category = _categoty;
                                        }
                                        categoryStatus = false;
                                      });
                                    },
                                  ),
                          ],
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onChanged: (String value) {
                            total = double.parse(value);
                          },
                          decoration: InputDecoration(
                            labelText: "Total Amount: ",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: key.currentState.brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87),
                            hintText: "Enter Expense Amount",
                          ),
                          initialValue: widget.expense.amount.toString(),
                          enabled: totalStatus,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            totalStatus == false
                                ? IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        totalStatus = true;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.check,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (total != null) {
                                          widget.expense.amount = total;
                                        }
                                        totalStatus = false;
                                      });
                                    },
                                  ),
                          ],
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Paid By: ",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: key.currentState.brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87),
                          ),
                          initialValue: widget.expense.payBy.firstName +
                              " " +
                              widget.expense.payBy.lastName,
                          enabled: false,
                        ),
                        flex: 4,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Share With: ",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              Card(
                            margin: EdgeInsets.only(top: 5),
                            child: ListTile(
                              selected: true,
                              leading: Icon(Icons.people),
                              title: Text(
                                widget.expense.sharedBy[index].firstName,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: key.currentState.brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black87),
                              ),
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Delete User"),
                                    content: Text(
                                        "Are you sure want to delete ${widget.expense.sharedBy[index].firstName}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.expense.sharedBy
                                                .removeAt(index);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text("Yes"),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                      ),
                                    ],
                                  ),
                                  barrierDismissible: false,
                                );
                              },
                            ),
                          ),
                          itemCount: widget.expense.sharedBy.length,
                        ),
                      ],
                    ))
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
