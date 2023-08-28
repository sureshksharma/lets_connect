

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_connect/domain/model/user.dart';

final authUserProvider = StateNotifierProvider<UserNotifier, UserData?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserData?> {
  UserNotifier() : super(null);
  void getUser(UserData user) {
    state = user;
  }
}