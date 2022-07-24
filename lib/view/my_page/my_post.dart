import 'package:flutter/material.dart';

class MyPost extends StatefulWidget {
  const MyPost({
    Key? key,
    required this.location,
    required this.imageUrl,
  }) : super(key: key);
  final String location;
  final String imageUrl; // 이미지를 담을 변수

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.location,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Image.network(
            widget.imageUrl,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
