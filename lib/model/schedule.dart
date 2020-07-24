import 'package:budgetgo/model/user.dart';

class Schedule {
  DateTime _startDt;
  DateTime _endDt;
  String _activityTitle;
  String _activityDesc;
  User _createdBy;
  DateTime _createdDt;
  String id;

  Schedule(this.id, this._startDt, this._endDt, this._activityTitle,
      this._activityDesc, this._createdBy, this._createdDt);

  Schedule.copy(Schedule from)
      : this(from.id, from.startDt, from.endDt, from.activityTitle,
            from.activityDesc, from.createdBy, from.createdDt);

  Schedule.empty(User user, DateTime start, DateTime end)
      : this('', start, end, '', '', user, DateTime.now());

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
        "createdBy": createdBy.id,
        "createdDt": createdDt.toString(),
        "id": id
      };

  Schedule.fromJson(json)
      : this(
            json['id'],
            convertdatetime(json['startDt']),
            convertdatetime(json['endDt']),
            json['activityTitle'],
            json['activityDesc'],
            User.fromJson(json['createdBy']),
            convertdatetime(json['createdDt']));

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
