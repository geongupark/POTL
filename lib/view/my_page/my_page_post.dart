import 'package:flutter/material.dart';

class MyPagePost extends StatelessWidget {
  const MyPagePost({
    Key? key,
    required this.imageUrl,
    required this.voteCnt,
    required this.index,
  }) : super(key: key);

  final String imageUrl;
  final int voteCnt;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        margin: EdgeInsets.only(
          left: index % 2 == 0 ? 8 : 0,
          right: index % 2 == 1 ? 8 : 0,
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
