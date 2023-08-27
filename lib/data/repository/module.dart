import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_connect/data/repository/user_impl.dart';
import 'package:lets_connect/domain/model/user.dart';
import 'package:lets_connect/domain/repository/auth.dart';
import '../../domain/repository/user.dart';
import 'auth_impl.dart';

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final usersProvider = Provider<UserRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return UserImpl(firestore);
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(authProvider);
  return auth.authStateChanges();
});

final authActionsProvider = Provider<AuthRepository>((ref) {
  final auth = ref.watch(authProvider);
  final firestore = ref.watch(firestoreProvider);
  return AuthImpl(auth, firestore);
});