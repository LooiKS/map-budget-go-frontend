import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/user.dart';

class Trips {
  String id;
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

  Trips({
    this.id,
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
          id: from.id,
          tripTitle: from.tripTitle,
          tripDetail: from.tripDetail,
          owner: from.owner,
          members:[...from.members],
          startDt: from.startDt,
          endDt: from.endDt,
          schedules: from.schedules,
          expenses: from.expenses,
          createdDt: from.createdDt,
          currency: from.currency,
          status: from.status,
        );
  Trips.fromJson(json)
      : this(
            id: json['id'],
            tripTitle: json['tripTitle'],
            tripDetail: json['tripDetail'],
            owner: User.fromJson(json['owner']),
            members: json["members"].map<User>((f) => User.fromJson(f)).toList(),
            startDt: convertdatetime(json['startDt']),
            endDt: convertdatetime(json['endDt']),
            schedules: json["schedules"].map<Schedule>((s) => Schedule.fromJson(s)).toList(),
            expenses: json["expenses"].map<TripExpenses>((e) => TripExpenses.fromJson(e)).toList(),
            createdDt: convertdatetime(json['createdDt']),
            currency: json['currency'],
            status: json['status'],
            );



  Map<String, dynamic> toJson() => {
        "id": id,
        "tripTitle": tripTitle,
        "tripDetail": tripDetail,
        "members": members == null ? null : members.map((f) => f.id).toList(),
        "owner": owner.id.toString(),
        "startDt": startDt.toString(),
        "endDt": endDt.toString(),
        "schedules": schedules == null ? null : schedules.map((s) => s.id).toList(),
        "expenses": expenses == null ? null : expenses.map((e) => e.id).toList(),
        "createdDt": createdDt.toString(),
        "currency": currency,
        "status": status,
      };

  String get _tripID => this.id;
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

  set _tripID(String newValue) => this.id = newValue;
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

  static DateTime convertdatetime(String s) {
    int year = int.parse(s.split('-')[0]);
    int month = int.parse(s.split('-')[1]);
    int day = int.parse(s.split('-')[2].split(' ')[0]);
    int hour = int.parse(s.split('-')[2].split(' ')[1].split(':')[0]);
    int min = int.parse(s.split('-')[2].split(' ')[1].split(':')[1]);
    int sec =
        int.parse(s.split('-')[2].split(' ')[1].split(':')[2].split('.')[0]);
    return DateTime(year, month, day, hour, min, sec);
  }
}
