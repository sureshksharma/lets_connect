
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_connect/domain/listener.dart';
import 'package:lets_connect/domain/model/call_history.dart';

import '../../domain/repository/call.dart';

class CallImpl extends CallRepository {

  final FirebaseFirestore _firestore;


  CallImpl(this._firestore);

  @override
  Future<List<CallHistory?>?> getCallHistory(String uid) async {
    try {
      final querySnapshot = await _firestore.collection('calls').doc(uid).get();
      final List<CallHistory> callList = [];
      if(querySnapshot.exists) {
        callList.add(CallHistory(
            uid: querySnapshot.id,
            fullname: querySnapshot['fullname'],
            email: querySnapshot['email'],
            createdate: querySnapshot['createdate']
        ));
      }
      return callList;
    } catch(e) {}
    return null;
  }

  @override
  Future<void> insertCall(String createUserId, String createUserName, String createUserEmail, CallHistory model) async {
    try {
      //Save to the caller document
      await _firestore.collection('calls').doc(createUserId).set({
        'uid': model.uid,
        'fullname': model.fullname,
        'email': model.email,
        'createdate': model.createdate
      });

      //Save to the receiver document
      await _firestore.collection('calls').doc(model.uid).set({
        'uid': createUserId,
        'fullname': createUserName,
        'email': createUserEmail,
        'createdate': model.createdate
      });
    } catch(e) {}
  }

}