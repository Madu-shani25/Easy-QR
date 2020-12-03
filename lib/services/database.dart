import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference attendance = Firestore.instance.collection('logins');

  Future updateUserData(String name, String subject, int num) async{
    return await attendance.document(uid).setData({
      'name': name,
      'subject': subject,
      'num': num,
    });
  }

}