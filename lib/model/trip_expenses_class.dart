import 'package:budgetgo/model/user.dart';

class TripExpenses {
  String id;
  String title;
  String desc;
  String category;
  DateTime createdDt;
  double amount;
  User payBy;
  User createdBy;
  List<User> sharedBy;

  TripExpenses(
      {this.id,
      this.title,
      this.desc,
      this.category,
      this.createdDt,
      this.amount,
      this.payBy,
      this.createdBy,
      this.sharedBy});

  TripExpenses.copy(TripExpenses from)
      : this(
            id: from.id,
            title: from.title,
            desc: from.desc,
            category: from.category,
            createdDt: from.createdDt,
            amount: from.amount,
            payBy: from.payBy,
            createdBy: from.createdBy,
            sharedBy: [...from.sharedBy]);

  String get _id => this.id;
  String get _title => this.title;
  String get _desc => this.desc;
  String get _category => this.category;
  DateTime get _createdDt => this.createdDt;
  double get _amount => this.amount;
  User get _payBy => this.payBy;
  User get _createdBy => this.createdBy;
  List<User> get _sharedBy => this.sharedBy;

  set _id(String newValue) => this.id = newValue;
  set _title(String newValue) => this.title = newValue;
  set _desc(String newValue) => this.desc = newValue;
  set _category(String newValue) => this.category = newValue;
  set _createdDt(DateTime newValue) => this.createdDt = newValue;
  set _amount(double newValue) => this.amount = newValue;
  set _payBy(User newValue) => this.payBy = newValue;
  set _createdBy(User newValue) => this.createdBy = newValue;
  set _sharedBy(List<User> newValue) => this.sharedBy = newValue;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "category": category,
        "createdDt": createdDt.toString(),
        "amount": amount,
        "payBy": payBy.id,
        "createdBy": createdBy.id,
        "sharedBy":
            sharedBy == null ? null : sharedBy.map((f) => f.id).toList(),
      };
  TripExpenses.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          desc: json['desc'],
          category: json['category'],
          createdDt: convertdatetime(json['createdDt']),
          amount: json['amount'].toDouble(),
          payBy: User.fromJson(json['payBy']),
          createdBy: User.fromJson(json['createdBy']),
          sharedBy:
              json["sharedBy"].map<User>((f) => User.fromJson(f)).toList(),
        );

  static DateTime convertdatetime(String s) {
    int year = int.parse(s.split('-')[0]);
    int month = int.parse(s.split('-')[1]);
    int day = int.parse(s.split('-')[2].split(' ')[0]);
    // int hour = int.parse(s.split('-')[2].split(' ')[1].split(':')[0]);
    // int min = int.parse(s.split('-')[2].split(' ')[1].split(':')[1]);
    // int sec =
    //     int.parse(s.split('-')[2].split(' ')[1].split(':')[2].split('.')[0]);
    return DateTime(year, month, day);
  }
}
