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

  Schedule.copy(Schedule from)
      : this(from.startDt, from.endDt, from.activityTitle, from.activityDesc,
            from.createdBy, from.createdDt);

  Schedule.empty(User user)
      : this(DateTime.now(), DateTime.now(), '', '', user, DateTime.now());

  DateTime get startDt => this._startDt;
  DateTime get endDt => this._endDt;
  String get activityTitle => this._activityTitle;
  String get activityDesc => this._activityDesc;
  User get createdBy => this._createdBy;
  DateTime get createdDt => this._createdDt;
  bool equalTo(Schedule other) {
    if (this._startDt.compareTo(other._startDt) == 0 &&
        this._endDt.compareTo(other._endDt) == 0 &&
        this.activityTitle.compareTo(other.activityTitle) == 0 &&
        this.activityDesc.compareTo(other.activityDesc) == 0) return true;
    return false;
  }

  set startDt(DateTime newValue) => this._startDt = newValue;
  set endDt(DateTime newValue) => this._endDt = newValue;
  set activityTitle(String newValue) => this._activityTitle = newValue;
  set activityDesc(String newValue) => this._activityDesc = newValue;
  set createdBy(User newValue) => this._createdBy = newValue;
  set createdDt(DateTime newValue) => this._createdDt = newValue;

  toJson() => {
        "startDt": startDt.toString(),
        "endDt": endDt.toString(),
        "activityTitle": activityTitle,
        "activityDesc": activityDesc,
        "createdBy": createdBy.toJson(),
        "createdDt": createdDt.toString(),
      };
}
