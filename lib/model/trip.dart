import 'dart:ffi';
import 'package:budgetgo/model/user.dart';

class Trips {
  Users ownerUser;
  List<Users> memberUser;
  String tripName;
  String location;
  DateTime startDate;
  DateTime endDate;
  List<String> schedule;
  List<double> expense;
  DateTime createdDate;
  String currency;

  Trips(this.ownerUser, this.memberUser, this.tripName, this.location, this.startDate, this.endDate, this.schedule, this.expense, this.createdDate, this.currency);
  Trips.copy(Trips from) : this(from.ownerUser, from.memberUser, from.tripName, from.location, from.startDate, from.endDate, from.schedule, from.expense, from.createdDate, from.currency);
}

