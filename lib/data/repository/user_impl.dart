
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_connect/domain/listener.dart';
import 'package:lets_connect/domain/model/user.dart';
import 'package:lets_connect/domain/repository/user.dart';

class UserImpl extends UserRepository {
  final FirebaseFirestore _firestore;


  UserImpl(this._firestore);

  @override
  Future<List<UserData>?> getUsers() async {
    try {
      final querySnapshot = await _firestore.collection('users').get();

      final userList = querySnapshot.docs.map((doc) {
        final data = doc.data();
        print('Data: $data');
        return UserData(
            fullname: data['fullname'],
            email: data['email'],
            createdate: data['createdate']
        );
      }).toList();
      return userList;
    } catch (e) {}
    return null;
  }

}