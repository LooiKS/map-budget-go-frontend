import 'package:budgetgo/model/trip_expenses_class.dart';

import './rest_service.dart';

class ExpensesDataService {
  static final ExpensesDataService _instance =
      ExpensesDataService._constructor();
  factory ExpensesDataService() {
    return _instance;
  }

  ExpensesDataService._constructor();
  final rest = RestService();
  final endpoint = 'expenses';

  Future<TripExpenses> createExpense(TripExpenses expense) async {
    return TripExpenses.fromJson(await rest.post(endpoint, data: expense));
  }

  Future<TripExpenses> updateExpense(String id, TripExpenses expense) async {
    return TripExpenses.fromJson(
        await rest.patch('$endpoint/$id', data: expense));
  }

  Future deleteExpense(String id) {
    return rest.delete('$endpoint/$id');
  }
} // class Expenses
