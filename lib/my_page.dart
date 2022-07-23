import 'package:flutter/material.dart';
import 'my_post.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<String> locations = [
    "서울시 강남구",
    "서울시 서초구",
    "서울시 관악구",
    "서울시 송파구",
    "경기도 수원시",
  ];
  final List<String> images = [
    "https://cdn2.thecatapi.com/images/bi.jpg",
    "https://cdn2.thecatapi.com/images/63g.jpg",
    "https://cdn2.thecatapi.com/images/a3h.jpg",
    "https://cdn2.thecatapi.com/images/a9m.jpg",
    "https://cdn2.thecatapi.com/images/aph.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: images.length, // 이미지 개수만큼 보여주기
        itemBuilder: (context, index) {
          final image = images[index]; // index에 해당하는 이미지
          final location = locations[index];
          return MyPost(location: location, imageUrl: image); // imageUrl 전달
        },
      ),
    );
  }
}
