
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/domain/model/user.dart';
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
  Future<UserData?> signInWithEmailAndPassword(String email, String password, DataListener listener) async {
    listener.onStarted();
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if(user != null) {
        final querySnapshot = await _firestore.collection('users').doc(user.uid).get();
        final userData = querySnapshot.data();
        final userDetail = UserData(
            uid: user.uid,
            fullname: userData?['fullname'],
            email: userData?['email'],
            createdate: userData?['createdate']
        );
        listener.onSuccess();
        return userDetail;
      } else {
        listener.onFailure('User not found.');
      }
    } catch(e) {
      listener.onFailure(e.toString());
    }
    return null;
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