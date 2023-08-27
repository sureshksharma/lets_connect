
import 'package:lets_connect/domain/listener.dart';

import '../model/user.dart';

abstract class UserRepository {
  Future<List<UserData>?> getUsers();
}