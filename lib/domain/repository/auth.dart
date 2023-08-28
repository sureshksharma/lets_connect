
import 'package:flutter/cupertino.dart';
import 'package:lets_connect/domain/listener.dart';
import 'package:lets_connect/domain/model/user.dart';

abstract class AuthRepository {
  Future<void> createUserWithEmailAndPassword(String email, String password, String fullName, String createDate, DataListener listener);

  Future<UserData?> signInWithEmailAndPassword(String email, String password, DataListener listener);

  Future<void> signOut(DataListener listener);
}