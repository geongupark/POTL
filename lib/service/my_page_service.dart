import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyPageService extends ChangeNotifier {
  final postCollection = FirebaseFirestore.instance.collection('post');
  final userCollection = FirebaseFirestore.instance.collection("user");

  Future<QuerySnapshot> readMyPosts(String uid) async {
    return postCollection.where('uid', isEqualTo: uid).get();
  }

  Future<QuerySnapshot> readMyInfo(String uid) async {
    return userCollection.where('uid', isEqualTo: uid).get();
  }

  void updateNickNameUserDoc(String docId, String nickName) async {
    // bucket isDone 업데이트
    await userCollection.doc(docId).update({'nick_name': nickName});
    notifyListeners(); // 화면 갱신
  }

  void updateProfileImageUserDoc(String docId, String profileImageUrl) async {
    // bucket isDone 업데이트
    await userCollection.doc(docId).update({'profile_image': profileImageUrl});
    notifyListeners(); // 화면 갱신
  }
}
