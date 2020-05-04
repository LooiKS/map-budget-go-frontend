import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/user.dart';

class Trips {
  String _tripTitle;
  String _tripDetail;
  User _owner;
  List<User> _members;
  DateTime _startDt;
  DateTime _endDt;
  List<Schedule> _schedules;
  List<TripExpenses> _expenses;
  DateTime _createdDt;
  String _currency;
  String _status;

  Trips(
    this._tripTitle,
    this._tripDetail,
    this._owner,
    this._members,
    this._startDt,
    this._endDt,
    this._schedules,
    this._expenses,
    this._createdDt,
    this._currency,
    this._status,
  );

  Trips.copy(Trips from)
      : this(
          from._tripTitle,
          from._tripDetail,
          from._owner,
          [...from.members],
          from._startDt,
          from._endDt,
          from._schedules,
          from._expenses,
          from._createdDt,
          from._currency,
          from._status,
        );

  String get tripTitle => this._tripTitle;
  String get tripDetail => this._tripDetail;
  User get owner => this._owner;
  List<User> get members => this._members;
  DateTime get startDt => this._startDt;
  DateTime get endDt => this._endDt;
  List<Schedule> get schedules => this._schedules;
  List<TripExpenses> get expenses => this._expenses;
  DateTime get createdDt => this._createdDt;
  String get currency => this._currency;
  String get status => this._status;

  set tripTitle(String newValue) => this._tripTitle = newValue;
  set tripDetail(String newValue) => this._tripDetail = newValue;
  set owner(User newValue) => this._owner = newValue;
  set members(List<User> newValue) => this._members = newValue;
  set startDt(DateTime newValue) => this._startDt = newValue;
  set endDt(DateTime newValue) => this._endDt = newValue;
  set schedules(List<Schedule> newValue) => this._schedules = newValue;
  set expenses(List<TripExpenses> newValue) => this._expenses = newValue;
  set createdDt(DateTime newValue) => this._createdDt = newValue;
  set currency(String newValue) => this._currency = newValue;
  set status(String newValue) => this._status = newValue;
}
