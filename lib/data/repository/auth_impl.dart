
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/domain/repository/auth.dart';
import '../../domain/listener.dart';

class AuthImpl extends AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthImpl(this._auth, this._firestore);

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password, String fullName, String createDate, DataListener listener) async {
    listener.onStarted();
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if(user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'fullname': fullName,
          'email': email,
          'createdate': createDate
        });
        listener.onSuccess();
      } else {
        listener.onFailure('Something went wrong!');
      }
    } catch(e) {
      listener.onFailure(e.toString());
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password, DataListener listener) async {
    listener.onStarted();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      listener.onSuccess();
    } catch(e) {
      listener.onFailure(e.toString());
    }
  }

  @override
  Future<void> signOut(DataListener listener)  async {
    listener.onStarted();
    try {
      await _auth.signOut();
      listener.onSuccess();
    } catch(e) {
      listener.onFailure(e.toString());
    }
  }

}