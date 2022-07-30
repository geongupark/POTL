import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoteService extends ChangeNotifier {
  final postCollection = FirebaseFirestore.instance.collection('post');
  final userCollection = FirebaseFirestore.instance.collection("user");

  Future<DocumentSnapshot> readTargetPost(String postId) async {
    // 내 post 가져오기
    return postCollection.doc(postId).get();
  }

  void updateVoting(int vote, String postId, String uid) async {
    // bucket isDone 업데이트
    await postCollection.doc(postId).update({'voting': vote});
    notifyListeners(); // 화면 갱신
  }

  void updateWarning(int warn, String postId, String uid) async {
    // bucket isDone 업데이트
    await postCollection.doc(postId).update({'warning': warn});
    notifyListeners(); // 화면 갱신
  }

  void delete(String docId) async {
    // bucket 삭제
    await postCollection.doc(docId).delete();
    notifyListeners(); // 화면 갱신
  }
}
