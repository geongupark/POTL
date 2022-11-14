import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeService extends ChangeNotifier {
  final postCollection = FirebaseFirestore.instance.collection('post');
  final userCollection = FirebaseFirestore.instance.collection("user");

  Future<QuerySnapshot> readAllPost() async {
    // 내 post 가져오기
    return postCollection.orderBy("voting", descending: true).get();
  }

  Future<QuerySnapshot> readAllPostBySorting() async {
    return postCollection
        .orderBy("voting", descending: true)
        .orderBy("time", descending: true)
        .get();
  }
}
