import 'package:budgetgo/model/user.dart';

import './rest_service.dart';

class UsersDataService {
  static final UsersDataService _instance = UsersDataService._constructor();
  factory UsersDataService() {
    return _instance;
  }

  UsersDataService._constructor();
  final rest = RestService();
  final endpoint = 'users';

  Future<User> createUser(User user) async {
    return User.fromJson(await rest.post(endpoint, data: user));
  }

  Future<User> getUser({String id}) async {
    final response = await rest.get('$endpoint/$id');
    print(response);
    return User.fromJson(response);
  }

  Future<User> updateUser({String id, User user}) async {
    print(user);
    final response = await rest.patch('$endpoint/$id', data: user);
    return User.fromJson(response);
  }
} // class User

final userDataService = UsersDataService();
