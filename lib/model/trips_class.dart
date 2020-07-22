import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/user.dart';

class Trips {
  int tripID;
  String tripTitle;
  String tripDetail;
  User owner;
  List<User> members;
  DateTime startDt;
  DateTime endDt;
  List<Schedule> schedules;
  List<TripExpenses> expenses;
  DateTime createdDt;
  String currency;
  String status;

  Trips(
      {this.tripID,
      this.tripTitle,
      this.tripDetail,
      this.owner,
      this.members,
      this.startDt,
      this.endDt,
      this.schedules,
      this.expenses,
      this.createdDt,
      this.currency,
      this.status});

  Trips.copy(Trips from)
      : this(
          tripID: from.tripID,
          tripTitle: from.tripTitle,
          tripDetail: from.tripDetail,
          owner: from.owner,
          members: [...from.members],
          startDt: from.startDt,
          endDt: from.endDt,
          schedules: from.schedules,
          expenses: from.expenses,
          createdDt: from.createdDt,
          currency: from.currency,
          status: from.status,
        );
  Trips.fromJson(Map<String, dynamic> json)
      : this(
          tripID: json['id'],
          tripTitle: json['data'],
          tripDetail: json['like'],
          owner: json['dislike'],
          members: json['dislike'],
          startDt: json['dislike'],
          endDt: json['dislike'],
          schedules: json['dislike'],
          expenses: json['dislike'],
          createdDt: json['dislike'],
          currency: json['dislike'],
          status: json['dislike'],
        );

  toJson() => {
        "tripID": tripID,
        "tripTitle": tripTitle,
        "tripDetail": tripDetail,
        "members": members.map((f) => f.toJson()).toList(),
        "owner": owner.toJson(),
        "startDt": startDt.toString(),
        "endDt": endDt.toString(),
        "schedules": schedules.map((f) => f.toJson()).toList(),
        "expenses": expenses.map((f) => f.toJson()).toList(),
        "createdDt": createdDt.toString(),
        "currency": currency,
        "status": status,
      };

  int get _tripID => this.tripID;
  String get _tripTitle => this.tripTitle;
  String get _tripDetail => this.tripDetail;
  User get _owner => this.owner;
  List<User> get _members => this.members;
  DateTime get _startDt => this.startDt;
  DateTime get _endDt => this.endDt;
  List<Schedule> get _schedules => this.schedules;
  List<TripExpenses> get _expenses => this.expenses;
  DateTime get _createdDt => this.createdDt;
  String get _currency => this.currency;
  String get _status => this.status;

  set _tripID(int newValue) => this.tripID = newValue;
  set _tripTitle(String newValue) => this.tripTitle = newValue;
  set _tripDetail(String newValue) => this.tripDetail = newValue;
  set _owner(User newValue) => this.owner = newValue;
  set _members(List<User> newValue) => this.members = newValue;
  set _startDt(DateTime newValue) => this.startDt = newValue;
  set _endDt(DateTime newValue) => this.endDt = newValue;
  set _schedules(List<Schedule> newValue) => this.schedules = newValue;
  set _expenses(List<TripExpenses> newValue) => this.expenses = newValue;
  set _createdDt(DateTime newValue) => this.createdDt = newValue;
  set _currency(String newValue) => this.currency = newValue;
  set _status(String newValue) => this.status = newValue;
}
