
import 'package:lets_connect/domain/listener.dart';

import '../model/call_history.dart';

abstract class CallRepository {
  Future<List<CallHistory?>?> getCallHistory(String uid);

  Future<void> insertCall(String createUserId, String createUserName, String createUserEmail, CallHistory model);
}