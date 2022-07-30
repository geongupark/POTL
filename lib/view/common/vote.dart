import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:potl/service/vote_service.dart';
import 'package:provider/provider.dart';

class VotePage extends StatefulWidget {
  const VotePage({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;
  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VoteService>(builder: (context, voteService, child) {
      return Scaffold(
        body: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: voteService.readTargetPost(widget.postId),
              builder: (context, snapshot) {
                final doc = snapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.network(
                          doc?.get("image_url") ??
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(Icons.arrow_back_ios),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_vert),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 375,
                          child: Text(
                            "176",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.place, color: Colors.white),
                              ),
                              Text(
                                doc?.get("location_name") ?? "여긴어디?",
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 270, bottom: 0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.star_outline,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                              ),
                            ),
                          ),
                          Text("사용자 ID"),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("인생샷 명소 주소"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.black),
                            ),
                            onPressed: () {},
                            child: Text("길찾기"),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // 지도
                        Image.network(
                          "https://greenblog.co.kr/wp-content/uploads/2020/03/%ED%81%AC%EA%B8%B0%EB%B3%80%ED%99%98_%EC%9A%B0%EB%A6%AC%EB%82%98%EB%9D%BC-%EC%A7%80%EB%8F%84.jpg",
                          height: 124,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      );
    });
  }
}
