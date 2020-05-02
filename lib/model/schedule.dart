import 'package:budgetgo/model/user.dart';

class Schedule {
  DateTime _startDt;
  DateTime _endDt;
  String _activityTitle;
  String _activityDesc;
  User _createdBy;
  DateTime _createdDt;

  Schedule(this._startDt, this._endDt, this._activityTitle, this._activityDesc,
      this._createdBy, this._createdDt);

  DateTime get startDt => this._startDt;
  DateTime get endDt => this._endDt;
  String get activityTitle => this._activityTitle;
  String get activityDesc => this._activityDesc;
  User get createdBy => this._createdBy;
  DateTime get createdDt => this._createdDt;

  set startDt(DateTime newValue) => this._startDt = newValue;
  set endDt(DateTime newValue) => this._endDt = newValue;
  set activityTitle(String newValue) => this._activityTitle = newValue;
  set activityDesc(String newValue) => this._activityDesc = newValue;
  set createdBy(User newValue) => this._createdBy = newValue;
  set createdDt(DateTime newValue) => this._createdDt = newValue;
}
