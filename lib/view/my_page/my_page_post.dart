import 'package:flutter/material.dart';
import 'package:potl/util/POTL_icons.dart';
import 'package:potl/util/confing.dart';

import '../common/vote.dart';

class MyPagePost extends StatelessWidget {
  const MyPagePost({
    Key? key,
    required this.postId,
    required this.imageUrl,
    required this.voteCnt,
    required this.index,
  }) : super(key: key);

  final String postId;
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
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VotePage(
                postId: postId,
              ),
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
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15),
                  color: Color.fromARGB(60, 100, 100, 100),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
                child: Column(
                  children: [
                    Text(
                      voteCnt.toString(),
                      style: TextStyle(
                        color: potlWhite,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Icon(
                      POTLIcons.vote_enable,
                      color: potlWhite,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
