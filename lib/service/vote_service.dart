import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoteService extends ChangeNotifier {
  final postCollection = FirebaseFirestore.instance.collection('post');
  final userCollection = FirebaseFirestore.instance.collection("user");

  Future<DocumentSnapshot> readTargetPost(String postId) async {
    // 내 post 가져오기
    return postCollection.doc(postId).get();
  }

  Future<QuerySnapshot> readUserInfo(String postId) async {
    String uid = "";
    String nickName = "";
    await postCollection
        .doc(postId)
        .get()
        .then((value) => {uid = value.data()!["uid"]});
    return userCollection.where("uid", isEqualTo: uid).get();
  }

  void updateVoting(int vote, String postId) async {
    // bucket isDone 업데이트
    await postCollection.doc(postId).update({'voting': vote});
    notifyListeners(); // 화면 갱신
  }

  void updateVotingUsers(List<dynamic> votingUsers, String postId) async {
    await postCollection.doc(postId).update({'voting_users': votingUsers});
    notifyListeners();
  }

  void updateVotingPosts(List<dynamic> votingPosts, String uid) async {
    var targetId;
    await userCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                targetId = doc.id; //모든 document 정보를 리스트에 저장.
              })
            });
    await userCollection.doc(targetId).update({'voting_posts': votingPosts});
    notifyListeners();
  }

  void updateWarning(int warn, String postId) async {
    // bucket isDone 업데이트
    await postCollection.doc(postId).update({'warning': warn});
    notifyListeners(); // 화면 갱신
  }

  void delete(String postId) async {
    // bucket 삭제
    await postCollection.doc(postId).delete();
    notifyListeners(); // 화면 갱신
  }
}
