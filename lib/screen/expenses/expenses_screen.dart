import 'package:budgetgo/main.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/screen/expenses/expenses_details.dart';
import 'package:budgetgo/widget/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:budgetgo/services/expense_data_service.dart';
import 'add_expense.dart';

class ExpensesScreen extends StatefulWidget {
  final Trips trips;

  ExpensesScreen(this.trips);
  @override
  ExpensesScreenState createState() => ExpensesScreenState();
}

class ExpensesScreenState extends State<ExpensesScreen> {
  ExpensesDataService expensesDataService = ExpensesDataService();
  void _navigateAddExpenses() async {
    TripExpenses returnData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpenseScreen(
          widget.trips,
        ),
      ),
    );
    if (returnData != null) {
      setState(() {
        buildCreatedDialog(context);
      });
    }
  }

  void _navigateExpenseDetails(int index) async {
    TripExpenses returnData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailsScreen(
          widget.trips.expenses[index],
        ),
      ),
    );
    if (returnData != null) {
      setState(() {
        widget.trips.expenses[index] = returnData;
      });
    }
  }

  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(widget.trips),
        ),
        title: Text(
          "Trip Expenses",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Expenses',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  widget.trips.status != "past"
                      ? IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _navigateAddExpenses();
                          },
                        )
                      : new Container(),
                ],
              ),
            ),
            Container(
              height: 520.0,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                  child: ListTile(
                    selected: true,
                    leading: Container(
                      width: 48.0,
                      child: buildExpensesIcon(
                          widget.trips.expenses[index].category),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30.0,
                      ),
                      onPressed: () {
                        _navigateExpenseDetails(index);
                      },
                    ),
                    title: Text(
                      widget.trips.expenses[index].title,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: key.currentState.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black87),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Paid by ${widget.trips.expenses[index].payBy.firstName}",
                            style: TextStyle(
                                color: key.currentState.brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black54),
                          ),
                          Text(
                            widget.trips.expenses[index].createdDt.toString(),
                            style: TextStyle(
                                color: key.currentState.brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black54),
                          ),
                          Text(
                            widget.trips.expenses[index].amount.toString(),
                            style: TextStyle(
                                color: key.currentState.brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black54),
                          ),
                        ]),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Delete Expense"),
                          content: Text(
                              "Are you sure want to delete ${widget.trips.expenses[index].title}?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  expensesDataService.deleteExpense(
                                      widget.trips.expenses[index].id);
                                  widget.trips.expenses.removeAt(index);
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
                itemCount: widget.trips.expenses.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Total Expenses: ${calculateTotal(widget.trips.expenses)}",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future buildCreatedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(milliseconds: 1000), () {
            Navigator.of(context).pop(true);
          });
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 50.0,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Created!",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Icon buildExpensesIcon(String category) {
    switch (category) {
      case "Accommodation":
        return Icon(
          Icons.hotel,
          size: 38.0,
        );
        break;

      case "Transport":
        return Icon(
          Icons.airport_shuttle,
          size: 38.0,
        );
        break;

      case "Food & Beverage":
        return Icon(
          Icons.fastfood,
          size: 38.0,
        );
        break;

      case "Entertainment":
        return Icon(
          Icons.local_play,
          size: 38.0,
        );
        break;

      default:
        return Icon(
          Icons.attach_money,
          size: 38.0,
        );
        break;
    }
  }

  double calculateTotal(List<TripExpenses> expenses) {
    double total = 0;
    for (var i = 0; i < expenses.length; i++) {
      total += expenses[i].amount;
    }
    return total;
  }
}
