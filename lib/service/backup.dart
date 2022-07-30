import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostService extends ChangeNotifier {
  final postCollection = FirebaseFirestore.instance.collection('post');
  final userCollection = FirebaseFirestore.instance.collection("user");

  Future<QuerySnapshot> readAllPost() async {
    // 내 post 가져오기
    return postCollection.orderBy("voting", descending: true).limit(5).get();
  }

  Future<QuerySnapshot> readMyPost(String uid) async {
    // 내 post 가져오기
    return postCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String uid, String imageUrl, GeoPoint geoPoint,
      String locationName) async {
    // new post 만들기
    await postCollection.add({
      'uid': uid,
      'image_url': imageUrl,
      'voting': 0,
      'voting_users': [],
      'warning': 0,
      'warning_users': [],
      'geo_point': geoPoint,
      'location_name': locationName,
      'time': Timestamp.fromDate(DateTime.now())
    });
    notifyListeners(); // 화면 갱신
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
