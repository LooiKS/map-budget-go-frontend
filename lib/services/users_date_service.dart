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

  Future<User> getAllUser() async {
    return User.fromJson(await rest.get(endpoint));
  }

  Future<User> createUser(User user) async {
    return User.fromJson(await rest.post(endpoint, data: user));
  }

  Future<User> getUser({String id}) async {
    final response = await rest.get('$endpoint/$id');
    return User.fromJson(response);
  }

  Future<User> updateUser({String id, User user}) async {
    final response = await rest.patch('$endpoint/$id', data: user);
    return User.fromJson(response);
  }

  Future<User> getUserByEmail({String email}) async {
    try {
      final response = await rest.get('$endpoint?email=$email');
      if (response != null) {
        return User.fromJson(response);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
} // class User

final userDataService = UsersDataService();
