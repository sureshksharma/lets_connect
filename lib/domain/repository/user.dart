

import '../model/user.dart';

abstract class UserRepository {
  Future<List<UserData?>?> getUsers(String uid);
}