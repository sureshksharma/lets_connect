
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/domain/listener.dart';
import 'package:lets_connect/domain/model/user.dart';
import 'package:lets_connect/domain/repository/user.dart';

class UserImpl extends UserRepository {
  final FirebaseFirestore _firestore;


  UserImpl(this._firestore);

  @override
  Future<List<UserData?>?> getUsers(String uid) async {
    try {
      final querySnapshot = await _firestore.collection('users').get();

      final List<UserData> userList = [];
      querySnapshot.docs.forEach((doc) {
        if(uid != doc.id) {
          final data = doc.data();
          final userId = doc.id;
          userList.add(UserData(
              uid: userId,
              fullname: data['fullname'],
              email: data['email'],
              createdate: data['createdate']
          ));
        }
      });
      return userList;
    } catch (e) {}
    return null;
  }

}