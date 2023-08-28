
import 'package:lets_connect/domain/model/user.dart';

abstract class DataListener {
  void onStarted();
  void onSuccess();
  void onFailure(String message);
}

abstract class AuthListener {
  void onStarted();
  void onSuccess(UserData user);
  void onFailure(String message);
}