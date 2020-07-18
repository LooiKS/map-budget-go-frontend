import 'package:budgetgo/model/schedule.dart';

import './rest_service.dart';

class ScheduleDataService {
  static final ScheduleDataService _instance =
      ScheduleDataService._constructor();
  factory ScheduleDataService() {
    return _instance;
  }

  ScheduleDataService._constructor();
  final rest = RestService();
  final endpoint = 'schedules';

  Future<Schedule> createSchedule(String id, Schedule schedule) {
    return rest.post(endpoint, data: schedule);
  }

  Future<Schedule> updateSchedule(String id, Schedule schedule) async {
    print('$endpoint/$id'); //, data: schedule);
    return Schedule.fromJson(await rest.patch('$endpoint/$id', data: schedule));
  }

  Future<Schedule> deleteSchedule(String id) {
    return rest.delete('$endpoint/$id');
  }
} // class Schedule
