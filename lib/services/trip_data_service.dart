import 'package:budgetgo/model/trips_class.dart';

import './rest_service.dart';

class TripDataService {
  static final TripDataService _instance =
      TripDataService._constructor();
  factory TripDataService() {
    return _instance;
  }

  TripDataService._constructor();
  final rest = RestService();
  final endpoint = 'trips';

  Future<List<Trips>> getAllTrips() async {
    final listJson = await rest.get('trips');

    return (listJson as List)
        .map((itemJson) => Trips.copy(itemJson))
        .toList();
  }
}

  // Future<Schedule> createSchedule(String id, Schedule schedule) {
  //   return rest.post(endpoint, data: schedule);
  // }

  // Future<Schedule> updateSchedule(String id, Schedule schedule) async {
  //   print('$endpoint/$id'); //, data: schedule);
  //   return Schedule.fromJson(await rest.patch('$endpoint/$id', data: schedule));
  // }

  // Future<Schedule> deleteSchedule(String id) {
  //   return rest.delete('$endpoint/$id');
  // }
 // class Schedule
