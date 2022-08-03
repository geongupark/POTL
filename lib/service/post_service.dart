import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostService extends ChangeNotifier {
  final postCollection = FirebaseFirestore.instance.collection('post');
  final userCollection = FirebaseFirestore.instance.collection("user");

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
}
