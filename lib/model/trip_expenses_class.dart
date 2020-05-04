import 'package:budgetgo/model/user.dart';

class TripExpenses {
  String _title;
  String _desc;
  String _category;
  String _createdDt;
  double _amount;
  User _payBy;
  User _createdBy;
  List<User> _sharedBy;

  TripExpenses(
    this._title,
    this._desc,
    this._category,
    this._createdDt,
    this._amount,
    this._payBy,
    this._createdBy,
    this._sharedBy,
  );

  String get title => this._title;
  String get desc => this._desc;
  String get category => this._category;
  String get createdDt => this._createdDt;
  double get amount => this._amount;
  User get payBy => this._payBy;
  User get createdBy => this._createdBy;
  List<User> get sharedBy => this._sharedBy;

  set title(String newValue) => this._title = newValue;
  set desc(String newValue) => this._desc = newValue;
  set category(String newValue) => this._category = newValue;
  set createdDt(String newValue) => this._createdDt = newValue;
  set amount(double newValue) => this._amount = newValue;
  set payBy(User newValue) => this._payBy = newValue;
  set createdBy(User newValue) => this._createdBy = newValue;
  set sharedBy(List<User> newValue) => this._sharedBy = newValue;
}
